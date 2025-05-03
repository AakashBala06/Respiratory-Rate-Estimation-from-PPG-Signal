# Respiratory Rate Estimation from ICU PPG Signals

This project estimates a patient's respiratory rate (RR) using PPG (photoplethysmography) signals collected from the BIDMC ICU dataset on PhysioNet. The PPG data is filtered to extract the breathing component, and respiratory cycles (breaths) are counted using peak detection.

##  Objective

To estimate respiratory rate from non-invasive PPG signals by applying signal filtering and detecting peaks that represent breaths.

##  Dataset

- Source: [BIDMC PPG and Respiration Dataset](https://physionet.org/content/bidmc/1.0.0/)
- Format: MATLAB `.mat` file (`bidmc_data.mat`)
- Sample rate: 125 Hz
- Signals used: PPG (`data(i).ppg.v`)
- Ground truth (if available): Reference RR (`data(i).ref.params.rr`)

##  Tools & Environment

- MATLAB (tested in MATLAB Online)
- Signal Processing Toolbox

##  Method Overview

1. **Load Subject Data**
2. **Bandpass Filter (0.1–0.5 Hz)** to isolate respiratory frequencies from PPG
3. **Peak Detection** on the filtered signal to estimate breath count
4. **Respiratory Rate (RR)** = number of detected breaths per minute
5. Optional: Compare estimated RR to reference RR (if available)

##  Sample Output

- Raw PPG plot  
- Filtered PPG (respiration component)  
- Detected peaks with RR estimate in BPM

##  Example Result
Estimated Respitory Rate (from PPG): 21 BPM

##  Files

- `respiratory_rate_single_subject.m` – MATLAB script for single-subject RR estimation
- `raw_ppg_signal.png` – Raw signal visualization  
- `filtered_ppg_signal.png` – Filtered signal showing breathing component  
- `detected_breaths_rr.png` – Final breath detection and RR estimation plot


##  Future Improvements

- Batch processing of all subjects  
- Statistical analysis of accuracy (MAE, RMSE)  
- Add time-frequency analysis or comparison with other biosignals (e.g., ECG, impedance)

