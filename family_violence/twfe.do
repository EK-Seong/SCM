import excel "final_1821.xlsx", sheet(> "Sheet1") firstrow clear

tsset region period

gen Dt = (period >= 26)
gen Ddaegu = (region ==3)
gen DtDdaegu = Dt*Ddaegu

drop if region == 1
drop if region == 5
drop if region == 8
drop if region == 14

reg reports_per Dt Ddaegu DtDdaegu unemploy_rate_male unemploy_rate_female hotdays aver_age income_per log_male log_female crime_thousand, vce(robust)

gen D2 = (region == 2)
gen D4 = (region == 4)
gen D19 = (region == 19)
gen D6 = (region == 6)
gen D7 = (region == 7)
gen D9 = (region == 9)
gen D10 = (region == 10)
gen D11 = (region == 11)
gen D12 = (region == 12)
gen D13 = (region == 13)
gen D15 = (region == 15)
gen D16 = (region == 16)

reg reports_per Dt Ddaegu DtDdaegu unemploy_rate_male unemploy_rate_female hotdays aver_age income_per log_male log_female crime_thousand D2 D4 D6 D7 D10 D11 D12 D13 D15 D16 D19, vce(cluster region) noconstant

estimates store twfe
estimate table twfe



//////

gen Dt1 = (period==1)
gen Dt2 = (period==2)
gen Dt3 = (period==3)
gen Dt4 = (period==4)
gen Dt5 = (period==5)
gen Dt6 = (period==6)
gen Dt7 = (period==7)

gen DtDdaeguUnemp = DtDdaegu*(unemploy_rate_total)

reg reports_per Dt Ddaegu DtDdaegu DtDdaeguUnemp unemploy_rate_male unemploy_rate_female hotdays aver_age income_per log_male log_female crime_thousand D2 D4 D6 D7 D10 D11 D12 D13 D15 D16 D19 period, vce(cluster region) noconstant