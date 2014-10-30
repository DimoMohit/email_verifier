function allowDrop(ev){
   ev.preventDefault();
}

function drag(ev){
   ev.dataTransfer.setData("Text",ev.target.id);
}

function drop(ev){
   ev.preventDefault();
   var data="";
   $(".template-view").html("");
   //ev.target.appendChild(document.getElementById(data));
   data=ev.dataTransfer.getData("Text");
   //ev.source.appendChild(document.getElementById(data));
   ev.target.appendChild(document.getElementById(data));
   extractContaint();
   //ev.source.appendChild(document.getElementById(data));
}
function extractContaint(){
	console.log("ResizeCalled");
	//$('.template-view div').css('height','300px');
	$('.template-view div').css('width','100%');
	$('.template-view div .header-template').css('width','100%');
	$('.template-view div .header-template').css('height','60px');
	$('.template-view div .message-template').css('height','180px');
	$('.template-view div .footer-template').css('height','60px');
}
$(document).ready(function(){
   $('#Header').keyup(function(){
      $('.template-view div .header-template').html($('#Header').val());
   });
   $('.save-result').click(function(){
    var s=$("#location-filter").val();
    var lname=$(".list-name input").val();
    $.ajax({
        type: "GET",
        dataType: "html",
        url: "http://"+window.location.host+"/email/save_list?name="+lname+"&id="+$(".filters-result").html()+"",
        data:$(".filters-result").html
    })
    .done(function( msg ) {
        alert("Saved");
        console.log(lname);
    });
   });
   $('.reports').click(function(){
    //console.log(lname);
    var s=$("#location-filter").val();
    var lname=$("#afile").val();
    $.ajax({
        type: "GET",
        dataType: "html",
        url: "http://"+window.location.host+"/email/reportcart/id=1",
        data:$(".filters-result").html
    })
    .done(function( msg ) {
        alert(msg);
        console.log(msg);
    });
   });
   $('.save-list').click(function(){
    //console.log(lname);
    var s=$("#location-filter").val();
    var lname=$("#afile").val();
    $.ajax({
        type: "GET",
        dataType: "html",
        url: "http://"+window.location.host+"/email/email_store?id="+lname,
        data:$(".filters-result").html
    })
    .done(function( msg ) {
        alert("Saved");
        console.log(lname);
    });
   });
   $('.save-template').click(function(){
    //console.log(lname);
    var s=$(".template-view").html();
    console.log(s);
    $.post( "http://"+window.location.host+"/email/save_template",
     { code: s
     })
    .done(function( msg ) {
        alert("Saved");
    });
   });
   $('.delete-list').click(function(){
    //console.log(lname);
    var s=$("#location-filter").val();
    var lname=$("#afile").val();
    $.ajax({
        type: "GET",
        dataType: "html",
        url: "http://"+window.location.host+"/email/delete_email_file?id="+lname,
        data:$(".filters-result").html
    })
    .done(function( msg ) {
        alert("Deleted");
        console.log(lname);
    });
   });
   $('.apply-filter').click(function(){
   	var af=$("#age-from" ).val();
   	var ato=$("#age-to").val();
   	var sf=$("#salary-from").val();
   	var st=$("#salary-to").val();
   	var g=$("#gender-from").val();
   	var s=$("#location-filter").val();
        $.ajax({
            type: "GET",
            dataType: "html",
            url: "http://"+window.location.host+"/email/filter?age_from="+af+"&age_to="+ato+"&salary_from="+sf+"&salary_to="+st+"&gender="+g+"&state="+s+"",
        })
        .done(function( msg ) {
            var tempJ= $(".filters-result").html("0");
            var obj = jQuery.parseJSON(msg);
            $.each(obj,function(ob){
              tempJ= $(".filters-result").html();
              $(".filters-result").html(tempJ+","+obj[ob].id);
            });
            $(".lists-body").siblings(".col-md-10").hide();
   	        $(".lists-body").show();
            console.log(msg);
        });
   });
   $(".campaign-body").siblings(".col-md-10").hide();
   $(".campaign-body").show();
   $('#user_to').keyup(function(){
      $('.user-to').html($('#user_to').val());
   });
   $('#message').keyup(function(){
      $('.message-template').html($('#message').val());
   });
   $('#footer').keyup(function(){
      $('.footer-template').html($('#user_to').val());
   });
   $(".template").editable();
   $(".campaigns").click(function(){
     $(this).siblings().removeClass("active");
   	 $(this).addClass("active");
   	 $(".campaign-body").siblings(".col-md-10").hide();
   	 $(".campaign-body").show();
   });
   $(".lists").click(function(){
   	 $(this).siblings().removeClass("active");
   	 $(this).addClass("active");
   	 $(".lists-body").siblings(".col-md-10").hide();
   	 $(".lists-body").show();
   });
   $(".reports").click(function(){
   	 $(this).siblings().removeClass("active");
   	 $(this).addClass("active");
   	 $(".reports-body").siblings(".col-md-10").hide();
   	 $(".reports-body").show();
   });
   $('.edit-text').editable({
    touch : true, // Whether or not to support touch (default true)
    lineBreaks : true, // Whether or not to convert \n to <br /> (default true)
    toggleFontSize : true, // Whether or not it should be possible to change font size (defualt true)
    closeOnEnter : false, // Whether or not pressing the enter key should close the editor (default false)
    event : 'click', // The event that triggers the editor
    callback : function( data ) {
        // Callback that will be called once the editor looses focus
        if( data.content ) {
            // Content has changed...
        }
        if( data.fontSize ) {
            // the font size is changed
        }
 
        // data.$el gives you a reference to the element that was edited
        data.$el.effect('blink');
    }
  });
});