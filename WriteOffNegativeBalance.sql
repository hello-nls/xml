-- Looks for Closed Loans, in IPApproved with a past due balance. Principal balance is 0
-- XML sets loan to active, writes off billings, closes loan
--Robert Buchanan - 12/20/2018


Select '<NLS>'

union all

SELECT            '<LOAN UpdateFlag="1" LoanNumber="' + loanacct.loan_number + '" ' +
						'LoanStatusCode = "ACTIVE" />' +
					 '<TRANSACTIONS >' +
                           '<TRANSACTIONCODE TransactionCode="125" ' +
                                                                           'LoanNumber="' + loan_number + '" ' +
                                                                           'EffectiveDate="' + CONVERT(VARCHAR(20), date_due, 101)  + '" ' +
                                                                           'Amount="' + Cast(dbo.loanacct.total_past_due_balance as varchar(30)) + '"' +
																		   'UserDefined1="PRINCIPAL REDUCTION" ' +
                                                                           'DateDue="' + Convert(VarChar(21), date_due, 101) + '" ' +
                                                '/>' +
                     '</TRANSACTIONS>' +
					 '<LOAN UpdateFlag="1" LoanNumber="' + loanacct.loan_number + '" ' +
						'LoanStatusCode = "CLOSED" />' 
FROM            dbo.loanacct INNER JOIN
                         dbo.loanacct_statuses ON dbo.loanacct.acctrefno = dbo.loanacct_statuses.acctrefno INNER JOIN
                         dbo.loan_status_codes ON dbo.loanacct_statuses.status_code_no = dbo.loan_status_codes.status_code_no INNER JOIN
                         dbo.loanacct_payments_due ON dbo.loanacct.acctrefno = dbo.loanacct_payments_due.acctrefno
Where days_past_due !=0 and dbo.loanacct.status_code_no = '1' and dbo.loan_status_codes.status_code = 'IPAPPROVED'-- and dbo.loanacct.loan_number = 'IL00063973'

union all

Select '</NLS>'