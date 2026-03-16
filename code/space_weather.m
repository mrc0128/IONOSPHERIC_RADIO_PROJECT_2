clear; close all; clc;

websave('mag_7day.json',     'https://services.swpc.noaa.gov/products/solar-wind/mag-7-day.json');
websave('plasma_7day.json',  'https://services.swpc.noaa.gov/products/solar-wind/plasma-7-day.json');
websave('kp_index.json',     'https://services.swpc.noaa.gov/products/noaa-planetary-k-index.json');
websave('solar_indices.txt', 'https://services.swpc.noaa.gov/text/daily-solar-indices.txt');


%raw = fileread('test.json');
%data = jsondecode(raw);
%disp(data;

%for i = 1:5
%    disp(data{i});
%end 

%parse and load file data 

mag_raw = fileread('mag_7day.json');
plasma_raw = fileread('plasma_7day.json');
kp_raw = fileread('kp_index.json');

mag_data = jsondecode(mag_raw);
plasma_data = jsondecode(plasma_raw);
kp_data = jsondecode(kp_raw);

%print row 2
%row = mag_data{2};
%disp(row)

%print rows 2-6
for i = 2:6
    row = mag_data{i};
    fprintf('Time: %s Bx: %s Bz: %s Bt: %s\n', row{1}, row{2}, row{4}, row{7})
end

%datetime conversion 
row = mag_data{2};
t = datetime(row{1}(1:19), 'InputFormat','yyyy-MM-dd HH:mm:ss');
disp(t)

%filter for march 10 

for i = 2:numel(mag_data)
    row = mag_data{i};
    t = datetime(row{1}(1:19), 'InputFormat', 'yyyy-MM-dd HH:mm:ss');
    if datestr(t, 'yyyy-mm-dd') == '2026-03-10'
        count = count + 1;
    end
end







