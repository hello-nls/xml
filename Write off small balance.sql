Select '<NLS CommitBlock = "0">'

union all

SELECT        '<LOAN UpdateFlag="1" LoanNumber="' + loanacct.loan_number + '" />' +
					'<TRANSACTIONS CommitEachTransaction ="1" > 
							<TRANSACTIONCODE 
								TransactionCode ="440"  
								EffectiveDate="' +CONVERT(VARCHAR(20), GetDate(), 101)+ '"
								Amount="'+ Cast(loanacct.current_principal_balance as varchar(30))+ '"
								LoanNumber="' + loanacct.loan_number + '"
								UserDefined1="CLOSE LOAN" />' +				
					'<PAYMENT	
						EffectiveDate="' +CONVERT(VARCHAR(20), GetDate(), 101)+ '"
						Amount="'+ Cast(loanacct.current_principal_balance as varchar(30))+ '"
					    LoanNumber="' + loanacct.loan_number + '"	
						Options="4"/>'
				'</TRANSACTIONS>' 
				
FROM            loanacct
Where current_principal_balance <'10.00' and current_principal_balance >'0' and loanacct.status_code_no = '14'

union all

Select '</NLS>'
