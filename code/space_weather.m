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

%read raw file data and decode json format

mag_raw = fileread('mag_7day.json');
plasma_raw = fileread('plasma_7day.json');
kp_raw = fileread('kp_index.json');

mag_data = jsondecode(mag_raw);
plasma_data = jsondecode(plasma_raw);
kp_data = jsondecode(kp_raw);


