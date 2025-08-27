document.addEventListener("DOMContentLoaded", function () {
    function calculatePrice() {
        const alterationType = document.getElementById("alteration-type").value;
        const dateInput = document.getElementById("date").value;
        let price = 0;

        if (alterationType === "short" || alterationType === "long") {
            price += 500;
        } else if (alterationType === "patch") {
            price += 400;
        } else if (alterationType === "complete-redesign") {
            price += 1500;
        }

        if (dateInput) {
            const selectedDate = new Date(dateInput);
            const today = new Date();
            const diffTime = selectedDate - today;
            const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
            
            if (diffDays < 7) {
                price += 700;
            }
        }

        document.getElementById("price-display").innerText = `Estimated Price: Rs ${price}`;
    }

    function validateGarmentSelection() {
        const garment = document.getElementById("garment").value;
        const alterationType = document.getElementById("alteration-type");
        const date = document.getElementById("date");

        if (!garment) {
            alterationType.selectedIndex = 0;
            alterationType.disabled = true;
            date.value = "";
            date.disabled = true;
        } else {
            alterationType.disabled = false;
            date.disabled = false;
        }
    }

    validateGarmentSelection();
    document.getElementById("garment").addEventListener("change", validateGarmentSelection);
    document.getElementById("alteration-type").addEventListener("change", calculatePrice);
    document.getElementById("date").addEventListener("change", calculatePrice);
});
