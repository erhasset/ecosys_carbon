clear;close;clc;close all;
cd('C:\Erin\Matlab');%CHANGE %Directory where your codes are
dataDir='C:\Erin\Matlab\Erin\';%CHANGE %Directory where your data are
dat_num='05232023';%CHANGE %Date vector of when the measurements were taken - User is expected to fill this out accurately
Max_Meas_Num = 124; %Input max number of measurements in a single chamber measurement. Typically 122 for 2 minute chambers.

%% Read the files.
metadata=ImportMetaDataSheet([dataDir 'Trip' dat_num '\metadata_' dat_num '.csv']); %It must be in a folder called "Data" which must then have a folder called "Trip10242023" or something like that.
for i=1:length(metadata.start_time_ad) %Creating correct datetime column
    Correct_Start = string(metadata.Date(i)) + " " + string(timeofday(metadata.start_time_ad(i)));
    Correct_End = string(metadata.Date(i)) + " " + string(timeofday(metadata.end_time_ad(i)));
    metadata.RIGHT_Start(i) = datetime(Correct_Start,'InputFormat','dd-MMM-yyyy HH:mm:ss');
    metadata.RIGHT_End(i) = datetime(Correct_End,'InputFormat','dd-MMM-yyyy HH:mm:ss');
end
laserdata=ReadLI7810([dataDir 'Trip' dat_num '\' metadata.data_sheet{1}]);
for i=2:length(laserdata.TIME) %Creating correct datetime column
    Correct_Time = string(laserdata.DATE(i)) + " " + string(timeofday(laserdata.TIME(i)));
    laserdata.RIGHT_TIME(i) = datetime(Correct_Time,'InputFormat','dd-MMM-yyyy HH:mm:ss');
end

%% filter to relevant dates & times
meas_date = [datetime("05/23/2023",'InputFormat','MM/dd/yyyy'),datetime("05/23/2023",'InputFormat','MM/dd/yyyy')]; %CHANGE,%Input dates, if only one date than only include the one in the list

DayStart = datetime("05/23/2023 05:00:00",'InputFormat','MM/dd/yyyy HH:mm:ss'); %CHANGE,%Change to start of trip after laser warmup
DayEnd = datetime("05/23/2023 010:50:00",'InputFormat','MM/dd/yyyy HH:mm:ss'); %CHANGE,%Change to end of trip once all measurements have been taken
dayFiltFull=laserdata.DATE==meas_date;
dayFilt = sum(dayFiltFull,2);
notday = ~dayFilt;
laserdata.RIGHT_TIME(~dayFilt)=NaT;

rmvDate = laserdata.RIGHT_TIME > DayEnd | laserdata.RIGHT_TIME < DayStart;
laserdata.RIGHT_TIME(rmvDate)=NaT;

%% Remove bad diagnostic data
bad=laserdata.DIAG~=0;
laserdata.CO2(bad | ~dayFilt)=nan;
laserdata.CH4(bad | ~dayFilt)=nan;

%% Read in Presumed Chamber Data and Times
    CH4 = [];
    TotalTIME = [];
for i=1:length(metadata.Date)
    tfilt = laserdata.RIGHT_TIME>=metadata.RIGHT_Start(i) & laserdata.RIGHT_TIME<=metadata.RIGHT_End(i);%in between start time and end time
    tfiltered = laserdata.RIGHT_TIME(tfilt);
    TIME=laserdata.SECONDS(tfilt);
    TIME=TIME-TIME(1);
    tempCH4 = laserdata.CH4(tfilt);

    if isempty(CH4)
        if length(tempCH4) < Max_Meas_Num %Number may need to change depending on highest amount of measurements in sampling day
            counter = Max_Meas_Num - length(tempCH4);  
            for i=1:counter
                tempCH4(end+1) = nan;
            end
        CH4 = tempCH4;
        end
    else
        if length(tempCH4) < Max_Meas_Num %Number may need to change depending on highest amount of measurements in sampling day
            counter = Max_Meas_Num - length(tempCH4);  
            for i=1:counter
                tempCH4(end+1) = nan;
            end
            CH4 = [CH4 tempCH4];
        else
             CH4 = [CH4 tempCH4];
        end
    end

    if isempty(TotalTIME)
        if length(tfiltered) < Max_Meas_Num %Number may need to change depending on highest amount of measurements in sampling day
            counter = Max_Meas_Num - length(tfiltered);  
            for i=1:counter
                tfiltered(end+1) = NaT;
            end
        TotalTIME = tfiltered;
        end
    else
        if length(tfiltered) < Max_Meas_Num %Number may need to change depending on highest amount of measurements in sampling day
            counter = Max_Meas_Num - length(tfiltered);  
            for i=1:counter
                tfiltered(end+1) = NaT;
            end
            TotalTIME = [TotalTIME tfiltered];
        else
             TotalTIME = [TotalTIME tfiltered];
        end
    end
end



%% Plot Full Time-Series for Trip
hold on
plot(laserdata.RIGHT_TIME, laserdata.CH4,'color', 'g')
plot(TotalTIME,CH4,'color', 'r')
hold off
