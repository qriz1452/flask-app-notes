import unittest
from app import create_app

class TestAppIntegration(unittest.TestCase):
    def setUp(self):
        self.app = create_app()
        self.client = self.app.test_client()

    def tearDown(self):
        pass

    def test_home_page(self):
        response = self.client.get('/')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'Welcome to the Notes App', response.data)

    # Add more integration tests here

if __name__ == '__main__':
    unittest.main()
