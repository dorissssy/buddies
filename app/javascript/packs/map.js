function initMap() {
    let div = document.getElementById("map");
    let location = {
        lat: parseFloat(div.getAttribute("data-center-lat")),
        lng: parseFloat(div.getAttribute("data-center-lng"))
    };

    const map = new google.maps.Map(div, {
        zoom: 12,
        center: location
    });

    let events = document.querySelectorAll("li.event-result-item");
    events = Array.from(events);
    let eventInfo = events.map(event => {
        return {
            coords: {
                lat: parseFloat(event.getAttribute("data-latitude")),
                lng: parseFloat(event.getAttribute("data-longitude"))
            },
            title: event.children[0].innerText,
            address: event.getAttribute("data-address")
        }
    });

    let infoWindow = new google.maps.InfoWindow();
    let labelDict = {};
    eventInfo.forEach(event => {
        let name = event.coords['lat'] + "," + event.coords['lng'];
        if (labelDict.hasOwnProperty(name)) {
            labelDict[name] += 1;
        } else {
            labelDict[name] = 1;
        }
    });
    eventInfo.forEach((event, i) => {
        let name = event.coords['lat'] + "," + event.coords['lng'];
        const marker = new google.maps.Marker({
            position: event.coords,
            map: map,
            label: labelDict[name].toString(),
            title: `${event.title} \n ${event.address.split("-").join(" ")}`
        });

        marker.addListener("click", () => {
            infoWindow.close();
            infoWindow.setContent(marker.getTitle());
            infoWindow.open(marker.getMap(), marker);
        });
    });

    console.log(eventInfo);
    console.log(location);
    console.log(div);
}

window.initMap = initMap;