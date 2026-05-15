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

const inputElement = document.getElementById('sent');

inputElement.addEventListener('keydown', function(event) {
  if (event.key === 'Enter') {
    event.preventDefault(); // Prevents form submission if input is inside a <form>
    okSent();
  }
  else if (event.key === 'Escape') {
    event.preventDefault();
    closeSent();
  }
});

function myFunction(value) {
  console.log("Enter pressed! Input value:", value);
}

function editSent(wdg, needed) {
  document.getElementById('sent_dialog').style.display='block';
  const n = wdg.getAttribute('value');
  const sent = document.getElementById('sent');
  const sent_form = document.getElementById('sent_form');
  sent_form.elements['le_id'].value = wdg.getAttribute('name');
  sent_form.elements['needed'].value = needed;
  sent.value = n;
  sent.focus();
  sent.select();
  console.log(sent_form);
}

function closeSent() {
  const diag = document.getElementById('sent_dialog');
  diag.style.display = 'none';
}

function okSent() {
  const diag = document.getElementById('sent_dialog');
  const sent_form = document.getElementById('sent_form');
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
  const current_id = sent_form.elements['le_id'].value;
  const needed = +sent_form.elements['needed'].value;
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
        const elt = document.getElementById(current_id);
        elt.innerHTML = data.sent;
        if (needed > +data.sent)
          elt.style.background = "#f55";
        else
          elt.style.background = '#5df';
      }
    })
    .catch(error => {
      console.error('Fetch operation failed:', error);
    });
  diag.style.display = 'none';
}
