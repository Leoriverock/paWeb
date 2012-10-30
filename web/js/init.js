/*Esta funcion lo que hace es usar una funcion que viene en el jquery, llamada localScroll *
 *que esta en el jquery.localscroll-min.js y jquery.scrollTo-min.js que a su vez************
 *requiere de funciones del jquery.min.js y lo unico que hay que tener en cuenta************
 *es que hay que darle el valor por defecto donde se desplaza "xy" y los target*************
 *que no es mas que el div del #Contenido_main**********************************************
 *Esta funcion la saca de google o cualquier ejemplo parecido*******************************/
jQuery(function( $ ){
	$.localScroll.defaults.axis = 'xy';
	$.localScroll.hash({
		target: '#Contenido_main', 
		queue:true,
		duration:1500
	});
	$.localScroll({
		target: '#Contenido_main', 
		queue:true,
		duration:1500,
		hash:true,
		onBefore:function( e, anchor, $target ){
	
		},
		onAfter:function( anchor, settings ){
		}
	});
});