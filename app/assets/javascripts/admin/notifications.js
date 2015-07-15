jQuery(function($) {

   

    $(document).on("click",".lista_notifications_users",function(){
       return false;
    });
    $(document).on("click",".accept-friend",function(){

        id_user1 = $(this).attr("data-id");

        $.ajax({
            url: "/admin/accept_friend/"+ id_user1 +"/"+$("#usuario_c").val(),
            type: "GET",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
            }
        });

    });

    $(document).on("click",".reject-friend",function(){

        id_user1 = $(this).attr("data-id");
        alert(id_user1);
        $.ajax({
            url: "/admin/reject_friend/"+ id_user1 +"/"+$("#usuario_c").val(),
            type: "GET",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
            }
        });

    });

    //verifica sem tem uma nova notificação a cada 5 segundos

    //var refreshId = setInterval(function(){
    //    $.ajax({
    //        url: "/admin/notification/"+$("#usuario_c").val(),
    //        type: "GET",
    //        beforeSend: function (xhr) {
    //            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
    //        }
    //    });
    //}, 7000);

});
