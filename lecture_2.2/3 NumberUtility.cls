public class NumberUtility {

	public static List<Integer> getPrimeNumber(Integer N) {
		Integer numDivisors;
		List<Integer> primeNumber = new List<Integer>();
		
        for (Integer currentNumber = 1; currentNumber <= N; currentNumber++) {
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
    
    Public static List<Integer> getFibonacci(Integer N) {
        Integer currenNumber = 0;
        Integer prevNumber = 0;
        List<Integer> Fibonacci = new List<Integer>();
        
        while (currenNumber <= N) {
            Fibonacci.add(currenNumber);
            if (currenNumber == 0) {
                currenNumber = currenNumber + 1;
            } else {
                Integer temp = currenNumber;
                currenNumber = currenNumber + prevNumber;
                prevNumber = temp;    
            }      
        }     
        System.debug(Fibonacci);
        return Fibonacci;
    }
    
    public static Boolean getPalindrome (Long checkNumber) {
        String testString = String.valueOf(checkNumber);
        List<String> elements = testString.split('');
        List<String> reverse = new List<String>();
        
        for(Integer i = elements.size()-1; i >= 0; i--) {
            reverse.add(elements[i]);
        }
        Boolean palindrome = elements == reverse;
        System.debug('Palindrome = ' + palindrome);
        return palindrome;
    }  
}