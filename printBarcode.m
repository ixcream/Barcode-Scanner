clc;
clear all;
close all;

% Read values from RobotC in excel file
coffeeVal = xlsread('coffeeLog.csv', 'C1:C10000');
plot(coffeeVal)

% Moving Average Filter with window size of ws
ws= 100;
for i=1:length(coffeeVal)-(ws-1)
    coffeeValAvg(i)=sum(coffeeVal(i:i+(ws-1)))/ws;
end;
hold on
figure;
plot(coffeeValAvg)

for i=1:length(coffeeValAvg)-1
coffeeValAvgDif(i) = abs(coffeeValAvg(i+1) - coffeeValAvg(i));
end;
figure;
plot(coffeeValAvgDif);
hold on

[pks,locs] = findpeaks(coffeeValAvgDif,'MinPeakHeight',0.019,'MinPeakDistance',100);
plot(locs,pks,'or');

 widths = (locs(2:end)-locs(1:end-1));
 widths = floor(widths/min(widths))
  
  for i = 1:length(widths)
  
     if widths(i) > 1 
        widths(i) = 3;
     end; 
 end;
 
 widths

%**************Pattern Recognition Using Lookup Table
LOOKUPTABLE = [311113113; 113113113; 313113111; 111133113; %ABCD
    311133111; 113133111; 111113313; 311113311; %EFGH
    113113311; 111133311; 311111133; 113111133; %IJKL
    313111131; 111131133; 311131131; 113131131; %MNOP
    111111333; 311111331; 113111331; 111131331; %QRST
    331111113; 133111113; 333111111; 131131113; %UVWX
    331131111; 133131111;]; %YZ

CODE = str2num(strrep(num2str(widths), ' ', ''));
 
   character = find(LOOKUPTABLE == CODE)
   Letter = char(64+character)


