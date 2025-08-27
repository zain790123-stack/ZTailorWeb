function deleteRecord(id, table) {
    if (!id || !table) {
        alert("Invalid delete request: Missing ID or table name.");
        return;
    }
    if (!confirm("Are you sure you want to delete this record? This action cannot be undone.")) {
        return;
    }
    fetch(`deleteRecord?table=${encodeURIComponent(table)}&id=${encodeURIComponent(id)}`, {
        method: 'GET'
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("Server returned an error response.");
        }
        return response.text();
    })
    .then(result => {
        const trimmedResult = result.trim().toLowerCase();

        if (trimmedResult === 'success') {
            alert("Record deleted successfully.");
            location.reload(); 
        } else {
            alert("Delete failed: " + result);
        }
    })
    .catch(error => {
        console.error("Delete error:", error);
        alert("An error occurred while deleting the record: " + error.message);
    });
}


function editRecord(id, type) {
    let page = "";

    switch (type) {
        case 'tailoring':
            page = 'editTailoring.jsp';
            break;
        case 'alteration':
            page = 'editAlteration.jsp';
            break;
        case 'Login':
            page = 'editUser.jsp';
            break;
        default:
            alert("Invalid record type!");
            return;
    }

    window.location.href = `${page}?id=${id}`;
}

function updateStatus(id, status) {
    const url = 'orderupdate'; 

    fetch(`${url}?id=${id}&status=${status}`)
        .then(response => response.text())
        .then(result => {
            if (result.trim() === 'success') {
                alert("Status updated successfully.");
                location.reload();
            } else {
                alert("Failed to update status.");
            }
        })
        .catch(error => {
            console.error("Error:", error);
            alert("Something went wrong.");
        });
}
function TailorupdateStatus(id, status) {
    const url = contextPath + '/AffilateTailorupdate';

    fetch(`${url}?id=${encodeURIComponent(id)}&status=${encodeURIComponent(status)}`)
        .then(response => response.text())
        .then(result => {
            console.log("Raw response:", result);
            if (result.trim() === 'success') {
                alert("Status updated successfully.");
                location.reload();
            } else {
                alert("Failed to update status: " + result);
            }
        })
        .catch(error => {
            console.error("Error:", error);
            alert("Something went wrong: " + error.message);
        });
}


