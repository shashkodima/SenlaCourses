public class NumberUtility {
    
    public static List<Integer> getPrimeNumber(Integer n) {
        Integer numDivisors;
        List<Integer> primeNumber = new List<Integer>();
        
        for (Integer currentNumber = 1; currentNumber <= n; currentNumber++) {
            numDivisors = 0;
            
            for (Integer i = 1; i <= currentNumber; i++) {
                if (math.mod(currentNumber, i) == 0) {
                    numDivisors++;
                }
            }
            if (numDivisors <= 2) {
                primeNumber.add(currentNumber);
            }
        }
        System.debug(primeNumber);
        return primeNumber;
    }
    
    public static List<Integer> getFibonacci(Integer n) {
        Integer currenNumber = 0;
        Integer prevNumber = 0;
        List<Integer> fibonacci = new List<Integer> ();
        
        while (currenNumber <= n) {
            fibonacci.add(currenNumber);
            if (currenNumber == 0) {
                currenNumber = currenNumber + 1;
            } else {
                Integer temp = currenNumber;
                currenNumber = currenNumber + prevNumber;
                prevNumber = temp;
            }
        }
        System.debug(fibonacci);
        return fibonacci;
    }
    
    public static Boolean isPalindrome(Long checkNumber) {
        String testString = String.valueOf(checkNumber);
        List<String> elements = testString.split('');
        List<String> reverse = new List<String> ();
        
        for (Integer i = elements.size() - 1; i >= 0; i--) {
            reverse.add(elements[i]);
        }
        Boolean itIsPalindrome = elements == reverse;
        System.debug('Palindrome = ' + itIsPalindrome);
        return itIsPalindrome;
    }
}