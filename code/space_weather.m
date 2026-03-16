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

%filter for march 10 store bz values

bz_vals = [];
times = datetime.empty;

for i = 2:numel(mag_data)
    row = mag_data{i};
    t = datetime(row{1}(1:19), 'InputFormat', 'yyyy-MM-dd HH:mm:ss');
    if datestr(t, 'yyyy-mm-dd') == '2026-03-10'
        bz_vals(end+1) = str2double(row{4});
        times(end+1) = t;
    end
end

fprintf('Min Bz %.2f nT\n', min(bz_vals));

fprintf('Max Bz %.2f nT\n', max(bz_vals));

fprintf('Mean Bz %.2f nT\n', mean(bz_vals));

fprintf('Total MAG %d\n', numel(bz_vals));


%same for plasma
speed_vals = [];
density_vals = [];
pl_times = datetime.empty;

for i = 2:numel(plasma_data)
    row = plasma_data{i};
    t = datetime(row{1}(1:19), 'InputFormat', 'yyyy-MM-dd HH:mm:ss');
    if datestr(t, 'yyyy-mm-dd') == '2026-03-10'
        density_vals(end+1) = str2double(row{2});
        speed_vals(end+1) = str2double(row{3});  
        pl_times(end+1) = t;
    end
end

fprintf('Mean speed %.1f km/s\n', mean(speed_vals, 'omitnan'));

fprintf('Mean Density %.2f cm^-3\n', mean(density_vals, 'omitnan'));

fprintf('Total Plasma: %df\n', numel(speed_vals));

%debugging speed
%row = plasma_data{2};
%disp(str2double(row{3}))

%same for parsing kp
kp_vals = [];
kp_times = datetime.empty;
for i = 2:numel(kp_data)
    row = kp_data{i};
    t = datetime(row{1}(1:19), 'InputFormat', 'yyyy-MM-dd HH:mm:ss');
    if datestr(t, 'yyyy-mm-dd') == '2026-03-10'
        kp_vals(end+1) = str2double(row{2});
        kp_times(end+1) = t;
    end
end

fprintf('Mean Kp: %.2f\n', mean(kp_vals));

fprintf('Max Kp: %.2f\n', max(kp_vals));

fprintf('Total Kp rows: %d\n', numel(kp_vals));

%parsing solar indices
lines =readlines('solar_indices.txt');
for i = 1:numel(lines)
    line = strtrim(lines(i));
    if startsWith(line, '2026 03 10')
        parts = strsplit(line);
        flux = str2double(parts(4));
        ssn = str2double(parts(5));
        fprintf('flux: %d sfu\n', flux);
        fprintf('Sunspots: %d\n', ssn);
    end
end

%kp chart
figure;
bar(kp_times, kp_vals);
ylabel('Kp Index')
title('Geomagnetic Kp Index - March 10, 2026');
ylim([0 9]);
grid on;

%IMF plot
figure;
plot(times, bz_vals);
ylabel('Bz (nT)');
xlabel('Time (UTC)');
title('IMF Bz Component - March 10, 2026');
grid on;
yline(0, 'k--');

%solar wind plot
figure;
yyaxis left
plot(pl_times, speed_vals);
ylabel('Speed (km/s)');
yyaxis right
plot(pl_times, density_vals, 'r');
ylabel('Density (cm^{-3})');
legend('Speed', 'Density');

xlabel('Time (UTC)');
title('Solar Wind and Plasama - March 10, 2026');
grid on;
