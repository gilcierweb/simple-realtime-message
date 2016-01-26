var allowCrossDomain = function(req, res, next) {
    res.header('Access-Control-Allow-Origin', 'http://localhost:3000/');
    res.header('Access-Control-Allow-Credentials', true);
    res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE');
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
};

$(document).ready(function () {

    var opts = {
        lines: 13 // The number of lines to draw
        , length: 28 // The length of each line
        , width: 14 // The line thickness
        , radius: 42 // The radius of the inner circle
        , scale: 1 // Scales overall size of the spinner
        , corners: 1 // Corner roundness (0..1)
        , color: '#000000' // #rgb or #rrggbb or array of colors
        , opacity: 0.25 // Opacity of the lines
        , rotate: 0 // The rotation offset
        , direction: 1 // 1: clockwise, -1: counterclockwise
        , speed: 1 // Rounds per second
        , trail: 60 // Afterglow percentage
        , fps: 20 // Frames per second when using setTimeout() as a fallback for CSS
        , zIndex: 2e9 // The z-index (defaults to 2000000000)
        , className: 'spinner' // The CSS class to assign to the spinner
        , top: '50%' // Top position relative to parent
        , left: '50%' // Left position relative to parent
        , shadow: true // Whether to render a shadow
        , hwaccel: false // Whether to use hardware acceleration
        , position: 'absolute' // Element positioning
    };

    spinner_div = document.getElementById("loading-spin");
    spinner = new Spinner(opts);

    $(document).on("click", ".detail-message", function () {

        spinner.spin(spinner_div);

        var id= $(this).attr('id');
        //var dataString = {
        //    id: $(this).attr('id'),
        //
        //};
        $.ajax({
            type: "GET",
            url: "messages/"+id,
            //data: dataString,
            dataType: "json",
            cache: false,
            crossDomain: false,
            success: function (data) {
                //jQuery.parseJSON(data);
                //data =$.parseJSON(data);
                // alert(data.name);
                //var data = JSON.parse(data.responseText);
                //console.log(data);
                //alert(data);

                if (data) {
                    $("#show_name").html(data.name);
                    $("#show_email").html(data.email);
                    $("#show_subject").html(data.subject);
                    $("#show_message").html(data.message);
                    var socket = io.connect('http://' + window.location.hostname + ':3002');

                    socket.emit('update_count_message', {
                        update_count_message: 1
                    });
                }
                //setTimeout(function(){
                //    spinner.stop(spinner_div);
                //}, 5000);
                spinner.stop(spinner_div);
            }, error: function (xhr, status, error) {
                spinner.stop(spinner_div);
                alert('Error: ' + error);
            },

        });
        //return false;
    });
});

var socket = io.connect('http://' + window.location.hostname + ':3002');

socket.on('new_count_message', function (data) {

    $("#new_count_message").html(data.new_count_message);
    //$('#notif_audio').get(0).play();
    $('#notif_audio').trigger('play');
});

socket.on('update_count_message', function (data) {
    $("#new_count_message").html(data.update_count_message);

});

socket.on('new_message', function (data) {
    spinner.spin(spinner_div);
//setTimeout(function(){
//        spinner.stop(spinner_div);
//    }, 5000);
    $("#message-tbody").prepend('<tr><td>' + data.name + '</td><td>' + data.email + '</td><td>' + data.subject  + '</td><td>' + data.message + '</td><td>' + data.created_at + '</td><td><a style="cursor:pointer" data-toggle="modal" data-target=".bs-example-modal-sm" class="detail-message" id="' + data.id + '"><span class="glyphicon glyphicon-search"></span></a></td></tr>').fadeIn(40000);
    $("#no-message-notif").html('');
    $("#new-message-notif").html('<div class="alert alert-success" role="alert"> <i class="fa fa-check"></i><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>New message ...</div>');

    spinner.stop(spinner_div);
});
