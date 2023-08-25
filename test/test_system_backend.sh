#!/bin/bash

# Assuming your backend API is running on http://localhost:5000
BASE_URL="http://localhost:5000"

# Test endpoint 1: Test user registration
curl -X POST -H "Content-Type: application/json" -d '{"username":"user123", "password":"pass123"}' $BASE_URL/register

# Test endpoint 2: Test user login
curl -X POST -H "Content-Type: application/json" -d '{"username":"user123", "password":"pass123"}' $BASE_URL/login

# Add more test cases as needed

# Clean up (if necessary)
# Delete test users, clear test data, etc.

echo "Backend system tests complete"
