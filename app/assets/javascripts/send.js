$(document).ready(function () {

    var opts = {
        lines: 13 // The number of lines to draw
        ,
        length: 28 // The length of each line
        ,
        width: 14 // The line thickness
        ,
        radius: 42 // The radius of the inner circle
        ,
        scale: 1 // Scales overall size of the spinner
        ,
        corners: 1 // Corner roundness (0..1)
        ,
        color: '#000000                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ' // #rgb or #rrggbb or array of colors
        ,
        opacity: 0.25 // Opacity of the lines
        ,
        rotate: 0 // The rotation offset
        ,
        direction: 1 // 1: clockwise, -1: counterclockwise
        ,
        speed: 1 // Rounds per second
        ,
        trail: 60 // Afterglow percentage
        ,
        fps: 20 // Frames per second when using setTimeout() as a fallback for CSS
        ,
        zIndex: 2e9 // The z-index (defaults to 2000000000)
        ,
        className: 'spinner' // The CSS class to assign to the spinner
        ,
        top: '50%' // Top position relative to parent
        ,
        left: '50%' // Left position relative to parent
        ,
        shadow: true // Whether to render a shadow
        ,
        hwaccel: false // Whether to use hardware acceleration
        ,
        position: 'absolute' // Element positioning
    };

    spinner_div = document.getElementById("loading-spin");
    spinner = new Spinner(opts);

    $("#new_message").submit(function () {

        spinner.spin(spinner_div);

        var dataString = {
            message: {
                name: $("#message_name").val(),
                email: $("#message_email").val(),
                subject: $("#message_subject").val(),
                message: $("#message_message").val()
            }
        };

        $.ajax({
            type: "POST",
            url: "/messages",
            data: dataString,
            dataType: "json",
            cache: false,
            crossDomain: false,
            success: function (data) {

                $("#load").hide();
                $("#message_name").val('');
                $("#message_email").val('');
                $("#message_subject").val('');
                $("#message_message").val('');

                if (data) {

                    data_location = data.location;

                    $("#notif").html(data.notif);

                    var socket = io.connect('http://' + window.location.hostname + ':3002');
                    socket.emit('new_count_message', {
                        new_count_message: data.new_count_message
                    });

                    socket.emit('new_message', {
                        name: data_location.name,
                        email: data_location.email,
                        subject: data_location.subject,
                        message: data_location.message,
                        created_at: data_location.created_at,
                        id: data_location.id
                    });

                } else if (data.status == false) {
                    $("#message_name").val(data_location.name);
                    $("#message_email").val(data_location.email);
                    $("#message_subject").val(data_location.subject);
                    $("#message_message").val(data_location.message);
                    $("#notif").html(data.notif);
                }
                spinner.stop(spinner_div);

            }, error: function (xhr, status, error) {
                spinner.stop(spinner_div);
                alert('Error: ' + error);
            },
        });
        return false;
    });
});
