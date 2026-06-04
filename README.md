# Maternal and Child Health Analysis
### A Complete Statistical Analysis Project in R
#### Kampala, Uganda | Referral Hospital Setting | n = 2,008

## What This Project Is About

Every day, mothers walk into hospitals across Uganda carrying pregnancies complicated by anaemia, high blood pressure, HIV, and poverty. Every day, babies are born too small, too early, or too sick. Understanding which factors drive these outcomes — and by how much — is not an academic exercise. It is the foundation of evidence-based maternal health policy.

This project presents a complete, end-to-end statistical analysis of maternal and child health data from 2,008 mother-infant pairs delivering at two referral hospitals in Kampala, Uganda — Mulago National Referral Hospital and Kawempe Referral Hospital. It covers every stage of a professional health data analysis: from importing and cleaning raw data, to generating publication-ready tables and visualizations, to running and interpreting inferential statistical tests, to compiling a graduate-level Word report.

> **Important:** The dataset used in this project was generated using artificial intelligence (AI) for educational and portfolio purposes only. 
> It does not represent real patient data. All findings are illustrative and carry no clinical or policy implications. The dataset was designed to reflect realistic distributions of maternal and neonatal variables in an urban Ugandan referral hospital context, including realistic patterns of missing data and data entry errors.

## Why This Project Exists

This project was built as a structured learning exercise and professional portfolio piece, designed to demonstrate end-to-end analytical competency in R across a realistic health data scenario. It was developed by a medical doctor transitioning into health data analytics, with the specific goal of showing how clinical domain expertise and data science skills complement each other in public health research contexts.

The analytical framework demonstrated here — data inspection, cleaning, descriptive statistics, visualization, assumption checking, inferential testing, and reproducible reporting — is the same framework applied in real dissertation analyses, global health research, and health payer analytics contexts.

## The Research Questions

This analysis set out to answer five research questions:

1. **Population characteristics** — Who are the mothers in this cohort, and do the two hospitals serve comparable patient populations?

2. **HIV and birth weight** — Do babies born to HIV-positive mothers weigh significantly less than those born to HIV-negative mothers?

3. **Hypertension and maternal outcomes** — Does having a hypertensive disorder in pregnancy significantly affect how well the mother does after delivery?

4. **Predictors of neonatal death** — Which clinical factors are independently associated with a baby dying in the neonatal period?

5. **BMI and birth weight** — Does a mother's body mass index at her first antenatal visit predict how heavy her baby will be at birth?

## What the Analysis Found

Research Question - Key Finding 

- Population characteristics - The two facilities served broadly comparable populations. ANC attendance was the only significant difference (Kawempe mean 5 visits vs Mulago mean 4 visits, p = 0.034) 
- HIV and birth weight - HIV-positive mothers had significantly lower birth weight babies (2.81 kg vs 2.94 kg, p = 0.045), consistent with known effects of HIV on fetal growth 
- Hypertension and maternal outcome - Hypertensive disorder was strongly associated with worse maternal outcomes (χ² = 96.46, p < 0.001), driven by pre-eclampsia — only 30% of pre-eclamptic mothers had good outcomes 
- Predictors of neonatal death - NICU admission was the only significant predictor of neonatal death (OR = 13.08, 95% CI: 6.95–26.47, p < 0.001), reflecting severity of underlying neonatal pathology 
- BMI and birth weight - No significant correlation between booking BMI and birth weight (Spearman rho = 0.014, p = 0.554), suggesting first-trimester BMI alone is an insufficient predictor of fetal growth 

## The Dataset

The dataset contains 2,008 observations and 19 variables, covering:

 Variable - Description 

- patient_id - Unique patient identifier 
- facility - Delivery facility (Mulago or Kawempe) 
- age_years - Maternal age in years 
- parity - Number of previous deliveries 
- education - Educational attainment (None / Primary / Secondary / Tertiary) 
- hiv_status - HIV status (Positive / Negative) 
- bmi_booking - Body mass index at first antenatal visit (kg/m²) 
- hypertensive_disorder - Hypertensive disorder category (None / Gestational Hypertension / Pre-eclampsia) 
- diabetes_in_pregnancy - Diabetes diagnosis during pregnancy (Yes / No) 
- anc_visits - Number of antenatal care visits attended 
- gestational_age_weeks - Gestational age at delivery in weeks 
- haemoglobin_gdl - Maternal haemoglobin concentration (g/dL) 
- delivery_mode - Mode of delivery (SVD / C-Section / Assisted) 
- birth_weight_kg - Neonatal birth weight in kilograms 
- apgar_score_5min - Apgar score at five minutes of life 
- postpartum_haemorrhage - Postpartum haemorrhage (Yes / No) 
- maternal_outcome - Overall maternal outcome (Good / Fair / Poor) 
- nicu_admission - Neonatal ICU admission (Yes / No) 
- neonatal_death - Neonatal death (Yes / No) 

**Realistic imperfections built into the dataset:**
- Missing values across six variables at clinically realistic rates
- Implausible values (e.g. maternal age of 8, gestational age of 46 weeks) requiring clinical judgment to handle
- Suspected duplicate records reflecting real-world data entry challenges
- BMI outliers requiring plausibility-based cleaning

## Analytical Methods

 Research Question | Statistical Test | Justification |

- RQ1 — Population characteristics | Descriptive statistics with gtsummary (by facility) | Comparative Table 1 with automated p-values |
- RQ2 — HIV and birth weight | Independent samples t-test | Birth weight normally distributed (Shapiro-Wilk W = 0.999, p = 0.426); two independent groups 
- RQ3 — Hypertension and maternal outcome | Pearson chi-square test | Both variables categorical; expected cell counts ≥ 5 in all cells 
- RQ4 — Predictors of neonatal death | Binary logistic regression | Binary outcome; multiple mixed-type predictors |
- RQ5 — BMI and birth weight | Spearman rank correlation | BMI failed normality assumption (Shapiro-Wilk W = 0.997, p = 0.0003) |

## Visualizations Produced

- Birth weight distribution — histogram
- ANC visits frequency — bar chart
- Delivery mode breakdown — bar chart
- Hypertensive disorder breakdown — bar chart
- Birth weight by LBW status — boxplot with clinical reference line
- Birth weight by HIV status — boxplot
- Birth weight by diabetes status — boxplot
- BMI versus birth weight — scatterplot with trend line
- Predictors of neonatal death — forest plot with log-scaled x-axis

## Data Cleaning Decisions

All cleaning decisions were clinically justified and documented:

Issue | Decision | Justification 

- Maternal ages < 15 or > 50 | Replaced with NA | Outside plausible range for delivering mothers; preserves valid data from other variables in same row 
- Gestational ages > 42 weeks | Replaced with NA | Post-term beyond 42 weeks would be managed before delivery in any functioning health system; attributable to data entry error 
- BMI < 14 or > 60 kg/m² | Replaced with NA | Physiologically implausible in an ambulatory obstetric population 
- Duplicate records | Flagged; retained | Differing patient IDs prevented automated deduplication; documented as limitation 
- Missing values | Handled with na.rm = TRUE | Row deletion avoided to preserve sample size and data integrity 

## For Non-Technical Readers

You do not need to know R or statistics to understand what this project demonstrates. Here is what each file contains in plain language:

**The R script** (`MCH_analysis.R`)
Every calculation performed in this project, written out line by line with plain English comments explaining what each step does and why. Think of it as a recipe — every ingredient and instruction is listed in order.

**The Word report** (`MCH_report.docx`)
The final deliverable — a graduate-level analysis report structured as introduction, methods, results, discussion, limitations, conclusion, and references. Written for a non-technical audience with all statistical findings explained in plain language. This is the kind of document you would hand to a dissertation supervisor, a public health officer, or a funding body.

**The plots folder**
Nine publication-quality visualizations saved at 300 DPI, suitable for inclusion in academic reports or presentations.

**Table 1 and Table 2**
Standalone Word documents containing the population characteristics table and the inter-facility comparison table respectively — formatted to publication standard using the gtsummary package.

## R Packages Used

 Package | Purpose 

- tidyverse | Data manipulation, cleaning, and ggplot2 visualizations 
- ggplot2 | All data visualizations 
- gtsummary | Publication-ready Table 1 and comparative tables 
- flextable | Word document export 

## How to Reproduce This Analysis

1. Clone or download this repository
2. Open RStudio on your computer
3. Install required packages by running:
   ```r
   install.packages(c("tidyverse", "gtsummary", "flextable"))
	4.	Open MCH_analysis.R and run from top to bottom
	5.	To generate the full Word report, open MCH_report.Rmd
and click Knit → Knit to Word

The CSV dataset is included in the repository and will be readautomatically if your R script and CSV are in the same folder.

## HTML File
- <a href="https://rpubs.com/Patricia_Mugabe/1438483">MCH html file</a>

## About the Analyst

I am a medical doctor (MBChB) actively transitioning into health dataanalytics, with a focus on maternal and child health, global health, and payer analytics. My clinical training shapes how I approach data — not as abstract numbers, but as representations of real patients, real families, and real health system challenges.

This project is part of an active portfolio demonstrating end-to-end analytical capability across R, SQL, Python, Tableau, and Excel, built with the goal of bridging clinical domain expertise and rigorous data science in global health contexts.

Patricia Mugabe | MBChB
