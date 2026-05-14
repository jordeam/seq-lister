function location_create(obj) {
    var str = prompt("Nome da localização:", "");
    if (str != null) {
        str = str.trim();
        if (str.length > 0) {
            obj.locname.value = str;
            return true;
        }
        else
	    return false;
    }
    else
        return false;
}

var current_id = 0;

const inputElement = document.getElementById('sent');

inputElement.addEventListener('keydown', function(event) {
  if (event.key === 'Enter') {
    event.preventDefault(); // Prevents form submission if input is inside a <form>
    okSent();
  }
});

function myFunction(value) {
  console.log("Enter pressed! Input value:", value);
}

function editSent(wdg) {
  const diag = document.getElementById('sent_dialog');
  const n = wdg.getAttribute('value');
  const sent = document.getElementById('sent');
  current_id = wdg.getAttribute('name');
  sent.value = n;
  diag.style.display = 'block';
  sent.focus();
  sent.select();
}

function closeSent() {
  const diag = document.getElementById('sent_dialog');
  diag.style.display = 'none';
}

function okSent() {
  const diag = document.getElementById('sent_dialog');
  const sent = document.getElementById('sent');
  console.log(sent.value);
  const val = +sent.value;
  const requestOptions = {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({
      sent: val,
    }).toString(),
  };
  const req = new Request('/locationentry/'+current_id+'/sent', requestOptions);
  fetch(req)
    .then(res => {
      if (!res.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }
      console.log(res);
      return res.json(); // Returns a promise with the parsed JSON
    })
    .then(data => {
      console.log(data); // Use your JSON data here
      if (current_id > 0) {
        document.getElementById(current_id).innerHTML = data.sent;
      }
    })
    .catch(error => {
      console.error('Fetch operation failed:', error);
    });
  diag.style.display = 'none';
}
