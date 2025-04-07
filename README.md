## **Distribution Fitting Techniques in MATLAB**

This repository provides a comprehensive MATLAB implementation of three statistical distribution fitting methods — **Maximum Likelihood Estimation (MLE)**, **Method of Moments (MOM)**, and **Method of L-Moments (L-MOM)**. The project compares these techniques by fitting distributions to generated datasets and evaluating their performance using goodness-of-fit metrics and visual plots.

### 🚀 Features

- Implements MLE, MOM, and L-MOM for distribution fitting  
- Supports fitting Normal and Extreme Value distributions  
- Handles both full (20 samples) and reduced (15 samples) datasets  
- Uses Kolmogorov–Smirnov test for goodness-of-fit evaluation  
- Produces detailed visualizations for comparison

### 📊 Methods Compared

- **MLE (Maximum Likelihood Estimation):** Uses built-in `fitdist()` and `ksdist()` for robust parameter estimation.
- **MOM (Method of Moments):** Calculates parameters based on sample moments.
- **L-MOM (Method of L-Moments):** A more robust technique, especially for small samples and outliers.

### 📁 Repository Contents

- `distribution_fitting.m` – Main MATLAB script  
- `README.md` – Project documentation

### 📷 Outputs

- Histogram overlaid with fitted PDFs  
- Comparison between full and reduced sample fits  
- Goodness-of-fit statistics included in legends

### 🧰 Requirements

- MATLAB R2019b or newer  
- No external toolboxes required

### ▶️ How to Run

```matlab
distribution_fitting
```

Run the script in MATLAB after navigating to the project folder.

---

### 👨‍💻 Author

**Suja Shree Ravichandran**  
Ph.D. in ML-aided Optimization, IIT Madras  
Specializing in data-driven modeling, optimization, and statistical learning

---

### 📬 Contact

For any questions or collaboration opportunities, feel free to reach out via GitHub or academic channels.

---
