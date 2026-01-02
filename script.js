document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('calculator-form');
    const principalInput = document.getElementById('principal');
    const rateInput = document.getElementById('rate');
    const timeInput = document.getElementById('time');
    const simpleInterestElement = document.getElementById('simple-interest');
    const totalAmountElement = document.getElementById('total-amount');

    form.addEventListener('submit', function(e) {
        e.preventDefault();
        calculateInterest();
    });

    // Add real-time calculation on input change
    [principalInput, rateInput, timeInput].forEach(input => {
        input.addEventListener('input', function() {
            if (principalInput.value && rateInput.value && timeInput.value) {
                calculateInterest();
            }
        });
    });

    function calculateInterest() {
        const principal = parseFloat(principalInput.value);
        const rate = parseFloat(rateInput.value);
        const time = parseFloat(timeInput.value);

        // Validate inputs
        if (isNaN(principal) || isNaN(rate) || isNaN(time)) {
            return;
        }

        if (principal <= 0 || rate < 0 || time <= 0) {
            alert('Please enter valid positive numbers');
            return;
        }

        // Calculate simple interest: SI = (P * R * T) / 100
        const simpleInterest = (principal * rate * time) / 100;
        const totalAmount = principal + simpleInterest;

        // Display results with animation
        animateValue(simpleInterestElement, 0, simpleInterest, 800);
        animateValue(totalAmountElement, 0, totalAmount, 800);
    }

    function animateValue(element, start, end, duration) {
        const startTime = performance.now();
        
        function update(currentTime) {
            const elapsed = currentTime - startTime;
            const progress = Math.min(elapsed / duration, 1);
            
            const current = start + (end - start) * easeOutQuart(progress);
            element.textContent = '$' + current.toFixed(2);
            
            if (progress < 1) {
                requestAnimationFrame(update);
            }
        }
        
        requestAnimationFrame(update);
    }

    function easeOutQuart(t) {
        return 1 - Math.pow(1 - t, 4);
    }

    // Add input validation
    [principalInput, rateInput, timeInput].forEach(input => {
        input.addEventListener('keypress', function(e) {
            // Allow numbers, decimal point, and backspace
            if (!/[\d.]/.test(e.key) && !['Backspace', 'Delete', 'Tab', 'Enter'].includes(e.key)) {
                e.preventDefault();
            }
        });
    });
});