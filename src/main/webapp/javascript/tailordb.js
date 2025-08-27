function updateStatus(id, status, type) {
    // type should be 'suit' or 'alteration' to match servlet logic
    fetch(`UpdateTailorStatus?id=${id}&status=${status}&type=${type}`)
        .then(response => response.text())
        .then(result => {
            if (result.trim() === 'success') {
                alert("Status updated successfully.");
                location.reload(); // refresh to reflect changes
            } else if (result.trim() === 'invalid_type') {
                alert("Invalid request type.");
            } else {
                alert("Failed to update status.");
            }
        })
        .catch(error => {
            console.error("Error:", error);
            alert("Something went wrong.");
        });
}

function deleteRecord(id, type) {
    if (!confirm("Are you sure you want to delete this record?")) return;

    fetch(`TailorDeleteServlet?id=${id}&type=${type}`)
        .then(response => response.text())
        .then(result => {
            if (result.trim() === 'success') {
                alert("Record deleted successfully.");
                location.reload();
            } else {
                alert("Failed to delete record: " + result);
            }
        })
        .catch(error => {
            console.error("Error:", error);
            alert("An error occurred while deleting the record.");
        });
}



