/*******************************************************************************

 CSS on Sails Framework
 Title: Eligible API
 Author: XHTMLized.com
 Date: November 2012

 *******************************************************************************/



(function ($) {
    "use strict";

    jQuery.extend(jQuery.easing,{
        easeOutQuint: function (x, t, b, c, d) {
            return c*((t=t/d-1)*t*t*t*t + 1) + b;
        }
    });
    
    var App = {

        /**
         * Init Function
         */
        init: function () {
            $("body").removeClass("no-js");
            
            if ($('body').hasClass('home')) {
                this.homeCycle();
                this.customers();
            }

            if ($('body').hasClass('supporting')) {
                this.prettyPrint();
            }

            this.loggedMenu();
            this.customSelect();
            this.alertOverlay();

            if ($.browser.msie) {
                this.placeholders();
            }

            this.saveBtns();
            this.tabSwitching();
            this.signature();
            this.listTree();
            
        },

        /**
         * Fade in fade out slider on homepage
         */
        homeCycle: function () {
            $('.home .slides').cycle({
                fx: 'fade',
                speed: 2500,
                opacity: 0.999
            });
        },



        loggedMenu: function () {
            $('a.menu-toggler').on('click', function (e) {
                var $submenu = $(this) .siblings('.logged-submenu');
                e.preventDefault();
                e.stopPropagation();


                if (!$submenu.hasClass('opened')) {
                    $submenu.addClass('opened');
                } else {
                    $submenu.removeClass('opened');
                }
            });

            $('body').on('click', function () {
                $('.btn-sign-in .opened').removeClass('opened');
            });
        },

        customSelect: function () {
            $('select.custom').each(function () {
                $(this).JSizedFormSelect();
            });


        },

        placeholders: function () {
            $('input[placeholder], textarea[placeholder]').JSizedFormPlaceholder();
        },

        alertOverlay: function () {
            if ($('body .overlay').length) {
                $('.overlay').overlay({
                    load: true,
                    top: '30%',
                    closeOnClick: false,
                    close: 'a.btn.neutral',
                    mask: '#000000'
                });
            }
        },

        saveBtns: function () {
            $('input').bind('focus change', function () {
                if (document.body.style.transition === undefined && document.body.style.mozTransition === undefined && document.body.style.webkitTransition === undefined && document.body.style.oTransition === undefined) {
                    $(this).closest('form').find('footer').animate({
                        height: '65px'
                    }, 'slow', function () {
                        $(this).addClass('expanded');
                    });


                } else {
                    $(this).closest('form').find('footer').addClass('expanded');
                }
            });

            $('form footer').delegate('.btn', 'click', function () {
                if (document.body.style.transition === undefined && document.body.style.mozTransition === undefined && document.body.style.webkitTransition === undefined && document.body.style.oTransition === undefined) {
                    $(this).closest('footer').animate({
                        height: 0
                    }).removeClass('expanded');
                } else {
                    $(this).closest('footer').removeClass('expanded');
                }
            });
        },

        tabSwitching: function () {
            var
                $l1TabsCards = $('.tab-wrapper'),
                $l1TabsLabels = $('.tabs.primary'),
                $l2TabsCards = $('.tab-wrapper.secondary'),
                $l2TabsLabels = $('.tabs.secondary'),
                i,
                url;

            $l1TabsLabels.find('a').click(function (e) {
                e.preventDefault();

                url = $(this).attr('href');

                i = $l1TabsCards.length;
                while (i--) {
                    if (!$($l1TabsCards[i]).hasClass('secondary')) {
                        $($l1TabsCards[i]).removeClass('current');
                    }
                }
                $(url).addClass('current');

                $l1TabsLabels.removeClass('active');
                $l1TabsLabels.children().removeClass('active');
                $(this).addClass('active');
                $(this).parent().addClass('active');
            });

            $l2TabsLabels.find('a').click(function (e) {
                e.preventDefault();

                url = $(this).attr('href');

                $l2TabsCards.removeClass('current');
                $(url).addClass('current');

                $l2TabsLabels.removeClass('active');
                $l2TabsLabels.children().removeClass('active');
                $(this).addClass('active');
                $(this).parent().addClass('active');
            });
        },

        signature: function() {
            var nameinput = $('.dashboard .agreement input[name="name"]');

            nameinput.on('input keyup', function() {
                $(this).closest('ul').find('.mock-signature').html( $(this).val() );
            }).trigger('input');
        },

        prettyPrint: function() {
            window.prettyPrint();

            var button =            '.json-example .contracted',
                jsonDesc =          '.json-desc',
                jsonExample =       '.json-example',
                sidebar =           '#sidebar',
                content =           '#content',
                container =         '.container',
                button =            '.json-example .resize',
                buttonText =        '[Show full]',
                buttonTextAlt =     '[Back to normal]',
                jsonDescWidth =     parseInt($(jsonDesc).css('width')),
                jsonExampleWidth =  parseInt($(jsonExample).css('width')),
                sidebarWidth =      parseInt($(sidebar).css('width')),
                contentWidth =      parseInt($(content).css('width')),
                containerWidth =    parseInt($(container).css('width')),
                margin = containerWidth - sidebarWidth - jsonDescWidth - jsonExampleWidth,
                speed = 400,
                easing = 'easeOutQuint';

            $(button).html(buttonText);

            $('body').on('click', button, function() {
                console.log(1);

                if ( !$(this).hasClass('active') ) {

                    $(sidebar).animate({
                        'width': 0
                        }, speed, easing, function() {
                            $(sidebar).css({'overflow': 'hidden'})
                    });

                    $(content).animate({
                        'width': containerWidth
                    }, speed, easing);

                    $(jsonDesc).animate({
                        'width': jsonDescWidth + margin - 10
                    }, speed, easing);

                    $(jsonExample).animate({
                        'width': jsonExampleWidth + sidebarWidth
                    }, speed, easing);

                    $(this).addClass('active').html(buttonTextAlt);

                } else {

                    $(sidebar).css({'overflow': 'visible'});

                    $(sidebar).animate({
                        'width': sidebarWidth
                        }, speed, easing);

                    $(content).animate({
                        'width': contentWidth
                    }, speed, easing);

                    $(jsonDesc).animate({
                        'width': jsonDescWidth
                    }, speed, easing);

                    $(jsonExample).animate({
                        'width': jsonExampleWidth 
                    }, speed, easing);

                    $(this).removeClass('active').html(buttonText);
                }
            });
        },

        listTree: function() {
            var titles = $('.taxonomy-codes ul li+ul').prev('li'),
                toggleButton = $('.taxonomy-codes .toggle'),
                toggleButtonText = '[Expand all nodes]',
                toggleButtonTextAlt = '[Contract]';

            // events
            titles.addClass('group-title').on('click', function() {
                if ($(this).hasClass('unwrapped')) {
                    $(this).next('ul').slideUp(function() {
                        $(this).prev('li').removeClass('unwrapped');
                    });
                } else {
                    $(this).next('ul').slideDown();
                    $(this).addClass('unwrapped');
                }
            });

            toggleButton.on('click', function() {
                if ($(this).hasClass('active')) {
                    $(this).removeClass('active').html(toggleButtonText);
                    titles.next('ul').each(function() {
                        $(this).slideUp(function() {
                            $(this).prev('li').removeClass('unwrapped');
                        });
                    });
                } else {
                    $(this).addClass('active').html(toggleButtonTextAlt);
                    titles.next('ul').each(function() {
                        $(this).slideDown();
                        $(this).prev('li').addClass('unwrapped');
                    });
                }
            });

            // initial setup
            titles.next('ul').addClass('hidden');
            toggleButton.html(toggleButtonText);
            

        }
    };

    $(function () {
        App.init();
    });


})(jQuery);

