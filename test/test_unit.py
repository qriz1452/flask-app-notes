import unittest

# A simple function to demonstrate testing
def add(a, b):
    return a + b

# Define a test class that inherits from unittest.TestCase
class TestAddFunction(unittest.TestCase):
    
    # A test case that checks if 1 + 1 equals 2
    def test_add_positive_numbers(self):
        result = add(1, 1)
        self.assertEqual(result, 2)
        
    # Add more test cases here
    
if __name__ == '__main__':
    unittest.main()
