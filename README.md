<img src="http://i.imgur.com/v0uoJsc.png" height="85">

A small swift class providing quick regular expression checking.

##Supported Regex
- [x] AlphaNumericAccentedCharacters ```(Alphabet, Numeric, and Accented Characters)```
- [x] AlphaNumericAccentedCharactersWithSpaces
- [x] AlphaNumericWithSymbolsAndSpaces  ```(AlphabetNumericAccentedCharactersWithSpaces with symbols)```
- [x] Email
- [x] IPAddress
- [x] URL
- [x] ZipCodeUSA
- [x] ZipCodeAsia
- [x] Numeric ```(Whole and Decimal Numbers)```
- [x] NumericWhole
- [x] PhoneNumber


##Example Usage
###Finding ranges in a string
```swift
let emailBody = "Sure thing! My email is johndoe@example.com, and Linsey's is linseydoe@example.com"

let emailRanges = emailValidation.validRangesInString(emailBody)

for range in emailRanges {
    let emailAddress = NSString(string: emailBody).substringWithRange(range)
    print (emailAddress)
}
```
###Validate text input
```swift
func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    let backspacePressed = string.isEmpty
    
    let characterValidator = ValidationPolicy(conformsTo: RegexPattern.AlphaNumericAccentedCharactersWithSpaces)
    if characterValidator.validateString(string) || backspacePressed {
        return true
    }
    
    return false
}
```
###Validate an entire string
```swift
let ipAddress = "192.168.1.1"
let ipAddressValidator = ValidationPolicy(conformsTo: .IPAddress)

if ipAddressValidator.validateString(ipAddress) {
    print("Yup! That's a fine looking IP Address you got there.")
}
```

