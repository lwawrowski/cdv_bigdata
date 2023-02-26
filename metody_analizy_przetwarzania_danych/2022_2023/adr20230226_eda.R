load("data/fifa.RData")

library(summarytools)

descr(fifa)

freq(fifa$win_conditions)

view(dfSummary(fifa))

library(dlookr)

diagnose(fifa)

diag <- diagnose_numeric(fifa)

diag_cat <- diagnose_category(fifa)

diagnose_outlier(fifa)

diagnose_web_report(fifa)

library(dataReporter)

makeDataReport(fifa, output = "html")
