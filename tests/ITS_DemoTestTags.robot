*** Settings ***
Resource            ../resources/keywords.robot
Suite Setup          Setup Browser
Suite Teardown       End suite



*** Test Cases ***

ITS_SmokeTest
	[tags]            smoke
	Appstate       	    FrontPage
	LogScreenshot   C:/Users/Maari/Desktop/Qen_Screenshot/screenshot_123.png
	ClickText      	    ${Mini_Quick}
	TypeText	quantity	3
	TypeText	skuId		${ItemNumber_Quick}
	ClickText	${AddToCartButton_Quick}
	#Paypal Checkout
	#ClickElement           //*[@id\="replaced_with_paypal_check_button"]/input[5]
	#TypeText	email	rsivakumar@dss-partners.com
	#ClickText	Next
	#TypeText	password	raviS9840@
	#ClickText	Log in
	#ClickText	Continue
	ClickElement	//*[@id\="cartform"]/div[3]/div[3]/div[3]/div[2]/input[3]
	
	ClickText           GUEST CHECKOUT
	#ClickText	SHIP TO THIS ADDRESS
	#ClickText	REVIEW ORDER
	
	TypeText	First Name	Test
	TypeText	Last Name	Name
	TypeText	Email	maaritest1@gmail.com
	# Switch checkbox to off
	ClickCheckbox       I agree         off
	TypeText	shippingAddress_address1		2352 Test Street
	DROPDOWN	shippingAddress_country		United States
	# Verify Country Dropdown
	VerifySelectedOption	shippingAddress_country	United States
	TypeText            City           New York
	DROPDOWN            shippingAddress_state          California
	TypeText           Zip/Postal Code  55632
	ClickCheckbox		shippingAddressAsBilling		on
	VerifyCheckboxValue	shippingAddressAsBilling		on
	TypeText         Telephone        1234567890
	LogScreenshot
	ClickText           CONTINUE
	VerifyText	Payment Details
	DROPDOWN        billing_creditCartType		masterCard
	#VerifySelectedOption	billing_creditCartType		visa
	TypeText	Card Number	5425233430109903
	TypeText	Name On Card	TestCard
	TypeText	CVV/Security Code	324
	DROPDOWN	billing_expirationDate		06-Jun
	DROPDOWN	billing_expirationYear		2023
	LogScreenshot
	ClickText	REVIEW ORDER
	#UseTable	Merchandise Subtotal
	#VerifyText	$138.82
	#${SubTotal}	GetText		//*[@id\="checkout-items"]/tbody/tr/td[5]/p/strong
	#${Shipping}	GetText		//*[@id\="confirmationform"]/div[3]/div[1]/div[3]/div[2]/div[1]/div[2]
	#${Handling}	GetText		//*[@id\="confirmationform"]/div[3]/div[1]/div[3]/div[2]/div[2]/div[2]
	#${EstimateTax}	GetText		//*[@id\="confirmationform"]/div[3]/div[1]/div[3]/div[2]/div[3]/div[2]
	#${Order_TOTAL}	GetText		//*[@id\="confirmationform"]/div[3]/div[1]/div[3]/div[4]/div[2]/strong
	#ShouldBeEqual	${Order_TOTAL} ==	${SubTotal}+${Shipping}+${Handling}+${EstimateTax}
	ClickText	PLACE ORDER
	VerifyTexts	Thank you for your order!
	${ORDERID}	GetText		Your Order ID is	between=???
	LogScreenshot
ITS_RegressionTest
   	[tags]              regression
	Appstate       	    Frontpage
	LogScreenshot
	HoverText      	    Chemicals
	ClickText      	    Pool Algaecides
	LogScreenshot
	ClickText           In The Swim Pool Algaecide
	# Verify that quantity for item Y1004 is 1.. Use item nro as anchor
	VerifyInputValue    QTY:            1       anchor=Y1004
	# Buy 10 and add to cart:
	TypeText            QTY:            10      anchor=Y1004
	LogScreenshot
	ClickText           ADD TO CART             anchor=Y1004
	LogScreenshot
	# Some basic verifications:
	VerifyTexts         Description: 2 x 1/2 gallons, $39.99, 10, $399.90, View Cart (10)
	# Get Subtotal to variable.. We only want text after * : -chars
	${SUBTOTAL}         GetText         Estimated SUBTOTAL      between=* :???
	# and check that it's expected:
	ShouldBeEqual       $399.90       ${SUBTOTAL}
	ClickText           View Cart
	# Table elements can be handle as is if we want to be specific
	# Pick table instance using some text that are inside of it
	LogScreenshot
	UseTable            Description
	# Verify things from table..  r?xxx/c? = row that contains given text, cell 2
	VerifyTable         r?Y1004/c2      In The Swim Pool Algaecide*
	VerifyTable         r?Y1004/c3      Y1004
	VerifyTable         r?Y1004/c4      $39.99
	# If input element, use VerifyInputValue instead of table
	VerifyInputValue    r?Y1004/c5      10
	VerifyTable         r?Y1004/c6      $399.90
	# Get tell text to variable..:
	${TOTAL}            GetCellText     r?Y1004/c6
	# ..Let's compare saved total to subtotal we saved earlier:
	ShouldBeEqual       ${TOTAL}        ${SUBTOTAL}
	# Checkout, give invalid email and try to proceed:
	ClickText           CHECK OUT
	LogScreenshot
	ClickText           GUEST CHECKOUT
	TypeText	First Name	ITS
	TypeText	Last Name	TEST
	TypeText	Email	qentineltest01@mail.com
	# Switch checkbox to off
	ClickCheckbox       I agree         off
	# Verify it's off
	VerifyCheckboxValue  I agree        off
	TypeText	shippingAddress_address1		2352 Test Street
	DROPDOWN	shippingAddress_country		United States
	# Verify Country Dropdown
	VerifySelectedOption	shippingAddress_country	United States
	TypeText            City           New York
	DROPDOWN            shippingAddress_state          California
	TypeText           Zip/Postal Code  55632
	ClickCheckbox		shippingAddressAsBilling		on
	VerifyCheckboxValue	shippingAddressAsBilling		on
	TypeText         Telephone        1234567890
	LogScreenshot
	ClickText           CONTINUE
	VerifyText	Payment Details
	DROPDOWN        billing_creditCartType		visa
	#VerifySelectedOption	billing_creditCartType		visa
	TypeText	Card Number	4263982640269299
	TypeText	Name On Card	TestCard
	TypeText	CVV/Security Code	123
	DROPDOWN	billing_expirationDate		06-Jun
	DROPDOWN	billing_expirationYear		2021
	LogScreenshot
	ClickText	REVIEW ORDER
	LogScreenshot
	VerifyTexts	ITEMS IN ORDER
	UseTable            Description
	VerifyTable         r?Y1004/c2      In The Swim Pool Algaecide*
	VerifyTable         r?Y1004/c3      $39.99
	VerifyTable         r?Y1004/c4      10
	VerifyTable	r?Y1004/c5	$399.90
	#GetTableRow	Your Order Total
	ClickText	PLACE ORDER
	VerifyTexts	Thank you for your order!
	${ORDERID}	GetText		Your Order ID is	between=???
	LogScreenshot
ITS_SanityTest
   	[tags]              sanity
	Appstate       	    Frontpage
	LogScreenshot
	HoverText      	    Chemicals
	ClickText      	    Pool Algaecides
	HoverText      	    Chemicals
	ClickText      	    Pool Algaecides
	LogScreenshot
	ClickText           In The Swim Pool Algaecide
	# Verify that quantity for item Y1004 is 1.. Use item nro as anchor
	VerifyInputValue    QTY:            1       anchor=Y1004
	# Buy 10 and add to cart:
	TypeText            QTY:            10      anchor=Y1004
	LogScreenshot
	ClickText           ADD TO CART             anchor=Y1004
	LogScreenshot
	# Some basic verifications:
	VerifyTexts         Description: 2 x 1/2 gallons, $39.99, 10, $399.90, View Cart (10)
	# Get Subtotal to variable.. We only want text after * : -chars
	${SUBTOTAL}         GetText         Estimated SUBTOTAL      between=* :???
	# and check that it's expected:
	ShouldBeEqual       $399.90       ${SUBTOTAL}
	ClickText           View Cart
	# Table elements can be handle as is if we want to be specific
	# Pick table instance using some text that are inside of it
	LogScreenshot
	UseTable            Description
	# Verify things from table..  r?xxx/c? = row that contains given text, cell 2
	VerifyTable         r?Y1004/c2      In The Swim Pool Algaecide*
	VerifyTable         r?Y1004/c3      Y1004
	VerifyTable         r?Y1004/c4      $39.99
	# If input element, use VerifyInputValue instead of table
	VerifyInputValue    r?Y1004/c5      10
	VerifyTable         r?Y1004/c6      $399.90
	# Get tell text to variable..:
	${TOTAL}            GetCellText     r?Y1004/c6
	# ..Let's compare saved total to subtotal we saved earlier:
	ShouldBeEqual       ${TOTAL}        ${SUBTOTAL}
	# Checkout, give invalid email and try to proceed:
	ClickText           CHECK OUT
	LogScreenshot
	TypeText           j_username   rsivakumar@dss-partners.com
  	TypeText           password     123123
  	LogScreenshot
  	ClickText          LOGIN AND CHECKOUT
	LogScreenshot
	VerifyTexts	Shipping Address
	ClickText	SHIP TO THIS ADDRESS
	#ClickCheckbox	paypal	on
	VerifyCheckboxValue	paypal	off
	VerifyText	Payment Details
	DROPDOWN        billing_creditCartType		visa
	#VerifySelectedOption	billing_creditCartType		visa
	TypeText	Card Number	4263982640269299
	TypeText	Name On Card	TestCard
	TypeText	CVV/Security Code	123
	DROPDOWN	billing_expirationDate		06-Jun
	DROPDOWN	billing_expirationYear		2021
	LogScreenshot
	ClickText	REVIEW ORDER
	LogScreenshot
	VerifyTexts	ITEMS IN ORDER
	ClickText	PLACE ORDER
	VerifyTexts	Thank you for your order!
	${ORDERID}	GetText		Your Order ID is	between=???
	LogScreenshot
