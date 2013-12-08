//https://raw.github.com/fisshy/angular-drag-drop/master/src/dragandrop.js
//https://github.com/fisshy/angular-drag-drop/blob/master/example/index.html
AppController.directive( 'drag', function ( dndApi ) {
    var drags = [];
    return {
      restrict: 'A',
      scope: {
        drag: '=',
        whenStart : '=',
        whenEnd : '='
      },
      link: function ( scope, elem, attr, ctrl ) {
        elem[0].addEventListener( 'dragstart', function ( e ) {

          if ( drags.length === 0 ) {
            drags = document.querySelectorAll( '.drop' );
          }

          angular.forEach( drags, function ( value, key ) {
            angular.element(value).addClass('draging');
          } );

          elem.addClass('on-drag');

          dndApi.setData(scope.drag);

          (e.originalEvent || e).dataTransfer.effectAllowed = 'move';
          (e.originalEvent || e).dataTransfer.setData( 'text', 'no-data' );

          if(angular.isFunction(scope.whenStart)) {
            scope.whenStart(dndApi.getData());
            scope.$apply();
          }

        });

        elem[0].addEventListener( 'dragend', function ( e ) {

          elem.removeClass('on-drag');

          angular.forEach( drags, function ( value, key ) {
            angular.element(value).removeClass('draging');
          } );

          if(angular.isFunction(scope.whenEnd)){
            scope.whenEnd(dndApi.getData());
            scope.$apply();
          }

          dndApi.removeData();
        } );

        elem[0].draggable = true;

        elem.addClass('drag');
      }
    };
  });
AppController.directive( 'drop', function ( dndApi ) {

    var drags = [];

    return {
      scope: {
        whenDrop: '=',
        whenEnter : '=',
        whenLeave : '='
      },
      link: function ( scope, elem, attr, ctrl ) {
        var left = elem[0].offsetLeft,
            right = left + elem[0].offsetWidth,
            top = elem[0].offsetTop,
            bottom = top + elem[0].offsetHeight;

        elem[0].addEventListener( 'drop', function ( e ) {

          if(e.stopPropagation()) {
            e.preventDefault();
          }

          if(angular.isFunction(scope.whenDrop)) {
            scope.whenDrop(dndApi.getData(), elem);
          }

          if (drags.length === 0) {
            drags = document.querySelectorAll( '.drop' );
          }

          angular.forEach(drags, function (value, key) {
           angular.element(value).addClass('draging');
          });

          dndApi.removeData();

          scope.$apply();
        });

        elem[0].addEventListener ('dragenter', function(e){
          if(elem[0] === e.target) {
            if(angular.isFunction(scope.whenEnter)){
              scope.whenEnter(dndApi.getData(), elem);
            }
          }
        });

        elem[0].addEventListener ( 'dragleave', function(e){
          if((e.x < left || e.x > right) || (e.y < top  || e.y > bottom)) {
            if(angular.isFunction(scope.whenLeave)){
              scope.whenLeave(dndApi.getData(), elem);
              scope.$apply();
            }
          }
        });

        elem[0].addEventListener ( 'dragover', function ( e ) {
          if ( e.preventDefault ) {
            e.preventDefault();
          }

          return false;
        });

        elem.addClass('drop');
      }
    };

  }).factory('dndApi', function() {

    var dnd = {
      dragObject : {}
    };

    return {
      setData : function(data){
        dnd.dragObject = data;
      },
      removeData : function(){
        delete dnd.dragObject;
      },
      getData : function(){
        return dnd.dragObject;
      }
    };
  });

