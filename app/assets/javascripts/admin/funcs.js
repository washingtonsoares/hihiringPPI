jQuery(function($) {

    $("#content_busca").val("");
    $("#home-top").click();


    $('.estrela').on('click', function(){

      console.log($(this).data('peso'));
      console.log($("#usuario_c").val());
      console.log($("#publication_c").val());

        $.ajax({
                url: '/admin/rating/publication/'+$("#publication_c").val()+'/user/'+$("#usuario_c").val()+'/nota/'+$(this).data('peso'),
                type: "POST",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
                },success: function(response){
                    $('#tab-avaliacoes').click();
                    
                }
            });

    });

    $("#user_ocupation").on("change",function(){
        valor_ocupation = $(this).val();
        if(valor_ocupation == "Professor"){
            $("#select_inst").select2("val", "");
            $("#select_inst").attr("multiple","");
            $("#select_inst").removeClass("hide");
            $("#select_inst").select2({
                placeholder: "Selecione suas instituições"
            });
        }else{
            $("#select_inst").select2("val", "");
            $("#select_inst").removeAttr("multiple");
            $("#select_inst").removeClass("hide");
            $("#select_inst").select2({
                placeholder: "Selecione a instituição"
            });
        }
    });


    $("#default").on("submit",function(){


        if(valor_ocupation == "Professor"){
            faculdades_sel = [];
            faculdades_sel = $("#select_inst").val();

            $.ajax({
                url: "/admin/associa_user_faculdade/"+$("#usuario_c").val(),
                type: "GET",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
                },
                data: {
                    datafacu: {
                        faculdades_id: faculdades_sel
                    }
                },success: function(response){
                    $("#default").unbind().submit();
                }
            });

        }else{

            $.ajax({
                url: "/admin/associa_user_faculdade/"+$("#usuario_c").val()+"/"+$("#select_inst").select2("val"),
                type: "GET",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
                },success: function(response){
                    $("#default").unbind().submit();
                }
            });
        }


        return false;
    });



    $(document).on("click","#add_friend",function(){

        $.ajax({
            url: "/admin/new_friend/"+$("#usuario_c").val()+"/"+$("#usuario_a").val(),
            type: "GET",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
            },
            data: {
                datafriends: {
                    user1: $("#usuario_c").val(),
                    user2: $("#usuario_a").val()
                }
            }
        }).done(function (data) {
            $(".add-friend-icon").text("").removeClass("icon-plus").addClass("icon-time").text(" Convite enviado");
            $(".modal-add-friend").attr("href","javascript:void(0)");
            $("#myModalAddContato").modal("hide");
            jQuery.gritter.add({ title: 'Noticia', text: 'Convite enviado com sucesso!' });

        });
        return false;
    });

    $(document).on("click","#start_indication",function(){
        $.ajax({
            url: "/admin/indicate/"+$("#usuario_c").val()+"/"+$("#usuario_a").val(),
            type: "GET",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
                $(".spinning-email").removeClass("hide");
            },
            data: {
                dadosindicate: {
                    email: $("#email_indicate").val(),
                    obs: $("#observacao").val()
                }
            }
        }).done(function (data) {
            $(".spinning-email").addClass("hide");
            $("#myModalIndication").modal("hide");
            $("#email_indicate").val("");
            $("#observacao").val("");
            jQuery.gritter.add({ title: 'Noticia', text: 'Perfil indicado com sucesso!' });
        });
        return false;
    });

    $(document).on("click",".remover_publicacao",function(){

        este = $(this);
        $("#myModal2").modal("show");

        $("#confirma").on("click",function(event){
            $.ajax({
                url: "/admin/users/"+ $("#current_user").val() +"/publications/"+ $("#current_publicacao").val() +"/comments/"+este.attr("data-id"),
                type: "DELETE",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
                }
            });
            $(this).off("click");
            return false;
        });
        return false;

    });


    $("#select_image").on("click", function() {
        $("#files").click();
    });
    function handleFileSelect(evt) {
        evt.stopPropagation(); // Stop stuff happening
        evt.preventDefault();
        console.log("inicio");
        // document.getElementById('preview_imagem').innerHTML = "";
        var files = evt.target.files; // FileList object
        // Loop through the FileList and render image files as thumbnails.
        for (var i = 0, f; f = files[i]; i++) {
            // Only process image files.
            if (!f.type.match('image.*')) {
                continue;
            }
            var reader = new FileReader();
            // Closure to capture the file information.
            reader.onload = (function (theFile) {
                return function (e) {
                    // Render thumbnail.
                    var span = document.createElement('span');
                    span.innerHTML = ['<img  style="width: 180px; height: 140px;" src="', e.target.result,
                        '" title="', escape(theFile.name), '"/>'].join('');
                    document.getElementById('image_preview').innerHTML = "";
                    document.getElementById('image_preview').insertBefore(span, null);
                };
            })(f);
            console.log("iniciou a leitura");
            // Read in the image file as a data URL.
            reader.readAsDataURL(f);
        }
        console.log("fim de tudo");


        try {
            //$('form#myForm').submit();
            return ;
        }
        catch (ex) {
            console.error("outer", ex.message);
            return ;
        }

    }
    $(document).on('change', '#files', handleFileSelect);
    function handleFileSelectArchive(evt) {
        var files = evt.target.files; // FileList object

        // files is a FileList of File objects. List some properties.
        var output = [];
        for (var i = 0, f; f = files[i]; i++) {
            output.push('<strong>', escape(f.name), '</strong> (', f.type || 'n/a', ') - ',
                f.size, ' bytes.');
        }
        document.getElementById('file-info').innerHTML = output.join('');
    }
    $(document).on('change', '#archive', handleFileSelectArchive);
    $(function () {
            // data stolen from http://howmanyleft.co.uk/vehicle/jaguar_'e'_type
            var tax_data = [
                {"period": "2011 Q3", "licensed": 3407, "sorned": 660},
                {"period": "2011 Q2", "licensed": 3351, "sorned": 629},
                {"period": "2011 Q1", "licensed": 3269, "sorned": 618},
                {"period": "2010 Q4", "licensed": 3246, "sorned": 661},
                {"period": "2009 Q4", "licensed": 3171, "sorned": 676},
                {"period": "2008 Q4", "licensed": 3155, "sorned": 681},
                {"period": "2007 Q4", "licensed": 3226, "sorned": 620},
                {"period": "2006 Q4", "licensed": 3245, "sorned": null},
                {"period": "2005 Q4", "licensed": 3289, "sorned": null}
            ];
            Morris.Line({
                element: 'hero-graph',
                data: tax_data,
                xkey: 'period',
                ykeys: ['licensed', 'sorned'],
                labels: ['Licensed', 'Off the road'],
                lineColors:['#8075c4','#6883a3']
            });

            Morris.Donut({
                element: 'hero-donut',
                data: [
                    {label: 'Jam', value: 25 },
                    {label: 'Frosted', value: 40 },
                    {label: 'Custard', value: 25 },
                    {label: 'Sugar', value: 10 }
                ],
                colors: ['#41cac0', '#49e2d7', '#34a39b'],
                formatter: function (y) { return y + "%" }
            });

            Morris.Area({
                element: 'hero-area',
                data: [
                    {period: '2010 Q1', iphone: 2666, ipad: null, itouch: 2647},
                    {period: '2010 Q2', iphone: 2778, ipad: 2294, itouch: 2441},
                    {period: '2010 Q3', iphone: 4912, ipad: 1969, itouch: 2501},
                    {period: '2010 Q4', iphone: 3767, ipad: 3597, itouch: 5689},
                    {period: '2011 Q1', iphone: 6810, ipad: 1914, itouch: 2293},
                    {period: '2011 Q2', iphone: 5670, ipad: 4293, itouch: 1881},
                    {period: '2011 Q3', iphone: 4820, ipad: 3795, itouch: 1588},
                    {period: '2011 Q4', iphone: 15073, ipad: 5967, itouch: 5175},
                    {period: '2012 Q1', iphone: 10687, ipad: 4460, itouch: 2028},
                    {period: '2012 Q2', iphone: 8432, ipad: 5713, itouch: 1791}
                ],

                xkey: 'period',
                ykeys: ['iphone', 'ipad', 'itouch'],
                labels: ['iPhone', 'iPad', 'iPod Touch'],
                hideHover: 'auto',
                lineWidth: 1,
                pointSize: 5,
                lineColors: ['#4a8bc2', '#ff6c60', '#a9d86e'],
                fillOpacity: 0.5,
                smooth: true
            });

            Morris.Bar({
                element: 'hero-bar',
                data: [
                    {device: 'iPhone', geekbench: 136},
                    {device: 'iPhone 3G', geekbench: 137},
                    {device: 'iPhone 3GS', geekbench: 275},
                    {device: 'iPhone 4', geekbench: 380},
                    {device: 'iPhone 4S', geekbench: 655},
                    {device: 'iPhone 5', geekbench: 1571}
                ],
                xkey: 'device',
                ykeys: ['geekbench'],
                labels: ['Geekbench'],
                barRatio: 0.4,
                xLabelAngle: 35,
                hideHover: 'auto',
                barColors: ['#6883a3']
            });

            new Morris.Line({
                element: 'examplefirst',
                xkey: 'year',
                ykeys: ['value'],
                labels: ['Value'],
                data: [
                    {year: '2008', value: 20},
                    {year: '2009', value: 10},
                    {year: '2010', value: 5},
                    {year: '2011', value: 5},
                    {year: '2012', value: 20}
                ]
            });

            $('.code-example').each(function (index, el) {
                eval($(el).text());
            });
        });

});
