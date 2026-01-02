#!/bin/bash

# Simple Interest Calculator
# Formula: Simple Interest = (Principal * Rate * Time) / 100
# Total Amount = Principal + Simple Interest

echo "=================================="
echo "   Simple Interest Calculator"
echo "=================================="
echo

# Function to validate if input is a positive number
validate_number() {
    local input=$1
    local field_name=$2
    
    # Check if input is empty
    if [[ -z "$input" ]]; then
        echo "Error: $field_name cannot be empty!"
        return 1
    fi
    
    # Check if input is a valid number (including decimals)
    if ! [[ "$input" =~ ^[0-9]+\.?[0-9]*$ ]]; then
        echo "Error: $field_name must be a valid positive number!"
        return 1
    fi
    
    # Check if input is positive
    if (( $(echo "$input <= 0" | bc -l) )); then
        echo "Error: $field_name must be greater than 0!"
        return 1
    fi
    
    return 0
}

# Function to get user input with validation
get_input() {
    local prompt=$1
    local field_name=$2
    local input
    
    while true; do
        echo -n "$prompt: "
        read input
        
        if validate_number "$input" "$field_name"; then
            echo "$input"
            return 0
        fi
        echo "Please try again."
        echo
    done
}

# Get user inputs
echo "Please enter the following details:"
echo

principal=$(get_input "Enter Principal Amount (\$)" "Principal Amount")
echo

rate=$(get_input "Enter Rate of Interest (% per annum)" "Interest Rate")
echo

time=$(get_input "Enter Time Period (years)" "Time Period")
echo

# Calculate Simple Interest using bc for floating point arithmetic
simple_interest=$(echo "scale=2; ($principal * $rate * $time) / 100" | bc -l)

# Calculate Total Amount
total_amount=$(echo "scale=2; $principal + $simple_interest" | bc -l)

# Display results
echo "=================================="
echo "         CALCULATION RESULTS"
echo "=================================="
echo
printf "Principal Amount:    \$%.2f\n" "$principal"
printf "Interest Rate:       %.2f%% per annum\n" "$rate"
printf "Time Period:         %.2f years\n" "$time"
echo "--------------------------------"
printf "Simple Interest:     \$%.2f\n" "$simple_interest"
printf "Total Amount:        \$%.2f\n" "$total_amount"
echo "=================================="
echo

# Ask if user wants to calculate again
echo -n "Do you want to calculate again? (y/n): "
read choice

if [[ "$choice" =~ ^[Yy]$ ]]; then
    echo
    exec "$0"  # Restart the script
else
    echo "Thank you for using Simple Interest Calculator!"
    exit 0
fi