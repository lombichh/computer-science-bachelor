function riempiAutoCallback(theXhr, theElement) {
	if (theXhr.readyState === 4) {
		if (theXhr.status === 200) {
			if (theXhr.responseText != "")
				theElement.value = theXhr.responseText;
		}
	}

}

function riempiAutoIFrame(theUri, theHolder) {
	theHolder.innerHTML = '<iframe src="' + theUri + '" width="50%" height="50px">Il tuo browser non supporta gli iframe</iframe>';
}

function riempiAutoAJAX(theUri, theElement, theXhr) {
	theXhr.onreadystatechange = function() { riempiAutoCallback(theXhr, theElement); };

	try {
		theXhr.open("get", theUri, true);
	} catch(e) { alert(e); }

	theXhr.send(null);
}

function riempiAuto(uri, e) {
	var xhr = myGetXmlHttpRequest();

	if (xhr) riempiAutoAJAX(uri, e, xhr); 
	else riempiAutoIFrame(uri, e); 
}