options(scipen = 999)

# =======================
# Install packages
# =======================
install.packages("tidyverse")
library(tidyverse)

# =========================
# Import data set
# =========================
mch <- read.csv('/Users/patriciamugisha/Downloads/maternal child health 2000.csv')

# ========================
# Inspect data
# ========================
head(mch)
str(mch)
summary(mch)
View(mch)

# =========================
# Data Cleaning
# ========================
# Remove duplicates with distinct()
mch <- mch %>% distinct()

# Replace implausible ages (<15 or >50) with NA
mch$age_years[mch$age_years < 15 | mch$age_years > 50] <- NA

# Replace implausible gestational ages (>42) with NA
mch$gestational_age_weeks[mch$gestational_age_weeks > 42] <- NA

# Replace implausible BMI values (<14 or >60) with NA
mch$bmi_booking[mch$bmi_booking < 14 | mch$bmi_booking > 60] <- NA

summary(mch)

# Convert categorical variables to factors
mch$facility <- factor(mch$facility)
mch$education <- factor(mch$education, levels = c("None", "Primary", "Secondary", "Tertiary"), ordered = TRUE)
mch$hiv_status <- factor(mch$hiv_status)
mch$maternal_outcome <- factor(mch$maternal_outcome)
mch$nicu_admission <- factor(mch$nicu_admission)
mch$neonatal_death <- factor(mch$neonatal_death)
mch$delivery_mode <- factor(mch$delivery_mode)
mch$hypertensive_disorder <- factor(mch$hypertensive_disorder)
mch$diabetes_in_pregnancy <- factor(mch$diabetes_in_pregnancy)
mch$postpartum_haemorrhage <- factor(mch$postpartum_haemorrhage)

# Create your age group derived variable
mch$age_group <- cut(mch$age_years,
                     breaks = c(0, 19, 34, Inf),
                     labels = c("Adolescent(<20)", "Optimal (20-34)", "Advanced (>34)"),
                     right = TRUE)

# Create your low birth weight derived variable
mch$low_birth_weight <- ifelse(mch$birth_weight_kg < 2.5, "Yes", "No")
mch$low_birth_weight <- factor(mch$low_birth_weight)

summary(mch)

# ========================
# Descriptive statistics
# =========================
install.packages("gtsummary")
library(gtsummary)

install.packages("flextable")
library(flextable)

table1 <- mch %>%
  select(facility, age_years, parity, education, hiv_status, bmi_booking, hypertensive_disorder, diabetes_in_pregnancy, anc_visits, gestational_age_weeks, haemoglobin_gdl, delivery_mode, birth_weight_kg, apgar_score_5min, postpartum_haemorrhage, maternal_outcome, nicu_admission, neonatal_death, low_birth_weight, age_group) %>%
  tbl_summary(
    type = list(anc_visits ~ "continuous",
                parity ~ "continuous",
                apgar_score_5min ~ "continuous"),
    statistic = list(
      all_continuous() ~ "{mean} ({sd})",
      all_categorical() ~ "{n} ({p}%)"),
    missing = "no"
  ) %>%
  bold_labels()
table1 %>%
  as_flex_table() %>%
  save_as_docx(path = "Table1_MCH2000.docx")

# ============================
# Data Visualization
# ============================
install.packages("ggplot2")
library(ggplot2)

# Birth weight distribution → histogram
ggplot(mch, aes(x = birth_weight_kg)) +
  geom_histogram(binwidth = 0.3, fill = "purple", color = "white", na.rm = TRUE) +
  labs(
    title = "Distribution of Birth Weight",
    subtitle = "Maternal and Child Health Study, Kampala, Uganda",
    x = "Birth Weight (kg)",
    y = "Number of Newborns"
  ) +
  theme_minimal()
ggsave("mch_birthweight_distribution.png", 
       width = 8, height = 5, dpi = 300)

# ANC visits → bar chart
ggplot(mch, aes(x = factor(anc_visits))) +
  geom_bar(fill = "purple", na.rm = TRUE) +
  labs(
    title = "Distribution of Antenatal Care Visits",
    subtitle = "Maternal and Child Health Study, Kampala, Uganda",
    x = "Number of ANC Visits",
    y = "Number of Mothers"
  ) +
  theme_minimal()
ggsave("mch_anc_visits.png", width = 8, height = 5, dpi = 300)

# Delivery mode → bar chart
ggplot(mch, aes(x = delivery_mode, fill = delivery_mode)) +
  geom_bar() +
  labs(
    title = "Delivery Mode Distribution",
    subtitle = "Maternal and Child Health Study, Kampala, Uganda",
    x = "Delivery Mode",
    y = "Number of Mothers"
  ) +
  scale_fill_manual(values = c("Assisted" = "#DDA15E",
                               "SVD" = "#84A98C",
                               "C-Section" = "#e74c3c")) +
  theme_minimal() +
  theme(legend.position = "none")
ggsave("mch_delivery_mode.png", width = 8, height = 5, dpi = 300)

# Hypertensive disorder breakdown → bar chart
ggplot(mch, aes(x = hypertensive_disorder, fill = hypertensive_disorder)) +
  geom_bar() +
  labs(
    title = "Hypertensive Disorder Breakdown",
    subtitle = "Maternal and Child Health Study, Kampala, Uganda",
    x = "Hypertensive Disorder",
    y = "Number of Mothers"
  ) +
  scale_fill_manual(values = c("Pre-eclampsia" = "#e74c3c",
                               "Gestational Hypertension" = "#DDA15E",
                               "None" = "#84A98C"
                               )) +
  theme_minimal() +
  theme(legend.position = "none")
ggsave("mch_hypertensive_disorder_breakdown.png", width = 8, height = 5, dpi = 300)

# Birth weight by LBW status → boxplot
ggplot(mch %>% filter(!is.na(low_birth_weight)),
       aes(x = low_birth_weight, 
           y = birth_weight_kg, 
           fill = low_birth_weight)) +
  geom_boxplot(na.rm = TRUE) +
  labs(
    title = "Birth Weight Distribution by LBW Status",
    subtitle = "Maternal and Child Health Study, Kampala, Uganda",
    x = "Low Birth Weight",
    y = "Birth Weight (kg)"
  ) +
  scale_fill_manual(values = c("No" = "#84A98C",
                               "Yes" = "#e74c3c")) +
  geom_hline(yintercept = 2.5, linetype = "dashed", 
             color = "black") +
  theme_minimal() +
  theme(legend.position = "none")
ggsave("mch_birthweight_by_lbw.png", width = 8, height = 5, dpi = 300)

# Birth weight by HIV status → boxplot
ggplot(mch, aes(x = hiv_status, 
           y = birth_weight_kg, 
           fill = hiv_status)) +
  geom_boxplot(na.rm = TRUE) +
  labs(
    title = "Birth Weight Distribution by HIV Status",
    subtitle = "Maternal and Child Health Study, Kampala, Uganda",
    x = "HIV Status",
    y = "Birth Weight (kg)"
  ) +
  scale_fill_manual(values = c("Negative" = "#84A98C",
                               "Positive" = "#e74c3c")) +
  geom_hline(yintercept = 2.5, linetype = "dashed", 
             color = "black") +
  theme_minimal() +
  theme(legend.position = "none")
ggsave("mch_birthweight_by_hiv_status.png", width = 8, height = 5, dpi = 300)

# Birth weight by diabetes status → boxplot
ggplot(mch, aes(x = diabetes_in_pregnancy, 
             y = birth_weight_kg, 
             fill = diabetes_in_pregnancy)) +
  geom_boxplot(na.rm = TRUE) +
  labs(
    title = "Birth Weight Distribution by Diabetes Status",
    subtitle = "Maternal and Child Health Study, Kampala, Uganda",
    x = "Diabetes in Pregnancy",
    y = "Birth Weight (kg)"
  ) +
  scale_fill_manual(values = c("No" = "#84A98C",
                               "Yes" = "#e74c3c")) +
  geom_hline(yintercept = 2.5, linetype = "dashed", 
             color = "black") +
  theme_minimal() +
  theme(legend.position = "none")
ggsave("mch_birthweight_by_diabetes_status.png", width = 8, height = 5, dpi = 300)

# ============================
# Inferential Studies
# ============================
# RQ1. What are the characteristics of the study population across the two facilities?
table2 <- mch %>%
  select(facility, age_years, parity, education, hiv_status, bmi_booking, hypertensive_disorder, diabetes_in_pregnancy, anc_visits, gestational_age_weeks, haemoglobin_gdl, delivery_mode, birth_weight_kg, apgar_score_5min, postpartum_haemorrhage, maternal_outcome, nicu_admission, neonatal_death, low_birth_weight, age_group) %>%
  tbl_summary(by = facility,
    type = list(anc_visits ~ "continuous",
                parity ~ "continuous",
                apgar_score_5min ~ "continuous"),
    statistic = list(
      all_continuous() ~ "{mean} ({sd})",
      all_categorical() ~ "{n} ({p}%)"),
    missing = "no"
  ) %>%
  bold_labels() %>%
  add_p()
table2 %>%
  as_flex_table() %>%
  save_as_docx(path = "Table2_by_facility_MCH2000.docx")

# RQ2. Is there a significant difference in birth weight between HIV-positive and HIV-negative mothers?
shapiro.test(mch$birth_weight_kg)
 
t.test(birth_weight_kg ~ hiv_status, data = mch)

# RQ3. Does hypertensive disorder significantly affect maternal outcome?
chisq.test(table(mch$hypertensive_disorder,
                 mch$maternal_outcome))$expected
chisq.test(table(mch$hypertensive_disorder, mch$maternal_outcome))

table(mch$hypertensive_disorder, mch$maternal_outcome)

# RQ4. What factors are associated with neonatal death?
logistic_model <- glm(neonatal_death ~ birth_weight_kg + gestational_age_weeks + 
                        hiv_status + hypertensive_disorder + 
                        nicu_admission + diabetes_in_pregnancy,
                      data = mch,
                      family = binomial)
summary(logistic_model)

exp(cbind(OR = coef(logistic_model),
          confint(logistic_model)))
# Forest plot
# Create odds ratio dataframe
or_data_neonatal <- data.frame(
  predictor = c("Birth Weight", "Gestational Age", "HIV Positive", "Hypertension: None",
                "Hypertension: Pre-eclampsia","NICU Admission", "Diabetes"),
  OR = c(0.86508184, 0.99109071, 0.46758596, 1.58425886, 1.40306561, 13.07683275, 0.38614973),
  lower = c(0.5563824636, 0.8886976902, 0.0748395054, 0.6679197310, 0.4269693448, 6.9545130732, 0.0619570374),
  upper = c(1.3314764, 1.1063294, 1.5805760, 4.6763074, 4.9415883, 26.4665365, 1.2971306)   
)

# Forest plot
ggplot(or_data_neonatal, aes(x = OR, y = predictor)) +
  geom_point(size = 3, color = "purple") +
  geom_errorbarh(aes(xmin = lower, xmax = upper),
                 height = 0.2, color = "purple") +
  geom_vline(xintercept = 1, linetype = "dashed",
             color = "red") +
  scale_x_log10() +
  labs(
    title = "Predictors of Neonatal Death",
    subtitle = "Odds Ratios with 95% Confidence Intervals",
    x = "Odds Ratio",
    y = ""
  ) +
  theme_minimal()
ggsave("mch_forest_plot_neonataldeath.png", width = 8, height = 5, dpi = 300)

# RQ5. Is there a correlation between BMI and birth weight?
shapiro.test(mch$birth_weight_kg)
shapiro.test(mch$bmi_booking)

cor.test(mch$bmi_booking,
         mch$birth_weight_kg,
         method = "spearman",
         use = "complete.obs")

# Scatterplot
ggplot(mch, aes(x = bmi_booking, y = birth_weight_kg)) +
  geom_point(color = "purple", alpha = 0.6, na.rm = TRUE) +
  geom_smooth(method = "lm", color = "red",
              se = TRUE, na.rm = TRUE) +
  labs(
    title = "Maternal BMI vs Birth Weight",
    subtitle = "Spearman rho = 0.014, p = 0.5543",
    x = "Maternal BMI",
    y = "Birth Weight (kg)"
  ) +
  theme_minimal()
ggsave("mch_bmi_vs_birthweight.png", width = 8, height = 5, dpi = 300)


























