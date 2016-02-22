function confirm_delete(msg) {
    deleteCheckbox = document.getElementsByName("delete")[0];

    if (deleteCheckbox.checked) {
        return confirm(msg);
    }
}
