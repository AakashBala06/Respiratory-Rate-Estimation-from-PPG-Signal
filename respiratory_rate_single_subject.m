
% === Load Data ===
load('bidmc_data.mat');

% === Choose One Subject ===
i = 1;
ppg = data(i).ppg.v;
fs = data(i).ppg.fs;
t = (0:length(ppg)-1) / fs;

% === Filter the PPG Signal ===
d = designfilt('bandpassiir','FilterOrder',4, ...
    'HalfPowerFrequency1',0.1,'HalfPowerFrequency2',0.5, ...
    'SampleRate',fs);
ppg_filt = filtfilt(d, ppg);

% === Detect Breath Peaks ===
[peaks, locs] = findpeaks(ppg_filt, 'MinPeakDistance', round(fs*1.5));

% === Estimate Respiratory Rate ===
duration_min = (t(end) - t(1)) / 60;
estimated_rr = length(locs) / duration_min;

% === Plot Raw and Filtered Signal with Detected Breaths ===
figure;
subplot(2,1,1);
plot(t, ppg);
xlabel('Time (s)');
ylabel('Raw PPG');
title('Raw PPG Signal');
grid on;

subplot(2,1,2);
plot(t, ppg_filt);
hold on;
plot(t(locs), peaks, 'ro');
xlabel('Time (s)');
ylabel('Filtered PPG');
title(['Filtered PPG with Detected Breaths – Estimated RR = ' num2str(round(estimated_rr)) ' BPM']);
grid on;

% === Get Reference Respiratory Rate (if available) ===
ref_rr = NaN;
if isfield(data(i).ref.params, 'rr')
    rr_vals = data(i).ref.params.rr;
    if isnumeric(rr_vals)
        if isvector(rr_vals)
            rr_clean = rr_vals(~isnan(rr_vals));
            if ~isempty(rr_clean)
                ref_rr = mean(rr_clean);
            end
        elseif isscalar(rr_vals) && ~isnan(rr_vals)
            ref_rr = rr_vals;
        end
    end
end

% === Display Results ===
disp(['Estimated Respiratory Rate (from PPG): ', num2str(round(estimated_rr)), ' BPM']);
if ~isnan(ref_rr)
    disp(['Reference Respiratory Rate (from monitor): ', num2str(round(ref_rr)), ' BPM']);
else
    disp('Reference Respiratory Rate not available.');
end
