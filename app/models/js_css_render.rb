class JsCssRender
   
    def self.get_js(controller_name, page_name)
       
        if controller_name == 'homes' && page_name == 'index'
            
            ret = '<script type="text/javascript" src="/assets/plugins/parallax-slider/js/modernizr.js"></script>' +
                  '<script type="text/javascript" src="/assets/plugins/parallax-slider/js/jquery.cslider.js"></script>' +
                  '<script type="text/javascript" src="/assets/plugins/owl-carousel/owl-carousel/owl.carousel.js"></script>' +  
                  '<script type="text/javascript" src="/assets/js/plugins/owl-carousel.js"></script>' +
                  '<script type="text/javascript" src="/assets/js/plugins/parallax-slider.js"></script>' +
                  '<script type="text/javascript">' +
                  '      jQuery(document).ready(function() { ' +
                  '        	App.init(); ' +
                  '         OwlCarousel.initOwlCarousel(); ' +
                  '         ParallaxSlider.initParallaxSlider(); ' +
                  '      }); ' +
                  '</script>'
                  
        elsif controller_name == 'mypages' && ( page_name == 'overall' || page_name == 'user_info' || page_name == 'payment' || page_name == 'payment_return' )
                  
            ret = '<script type="text/javascript" src="/assets/plugins/counter/waypoints.min.js"></script>' +
                  '<script type="text/javascript" src="/assets/plugins/counter/jquery.counterup.min.js"></script>' +
                  '<script type="text/javascript" src="/assets/plugins/sky-forms-pro/skyforms/js/jquery-ui.min.js"></script>' +
                  '<script type="text/javascript" src="/assets/plugins/scrollbar/js/jquery.mCustomScrollbar.concat.min.js"></script>' +
                  '<script type="text/javascript" src="/assets/js/plugins/datepicker.js"></script>' +
                  '<script type="text/javascript">' +
                  '      jQuery(document).ready(function() { ' +
                  '        	App.init(); ' +
                  '         App.initCounter(); ' +
                  '         App.initScrollBar(); ' +
                  '         Datepicker.initDatepicker(); ' +
                  '      }); ' +
                  '</script>'   
                  
        elsif controller_name == 'inicis_payments' && page_name == 'new'
            
            ret = '<script type="text/javascript" src="/assets/plugins/counter/waypoints.min.js"></script>' +
                  '<script type="text/javascript" src="/assets/plugins/counter/jquery.counterup.min.js"></script>' +
                  '<script type="text/javascript" src="/assets/plugins/sky-forms-pro/skyforms/js/jquery-ui.min.js"></script>' +
                  '<script type="text/javascript" src="/assets/plugins/scrollbar/js/jquery.mCustomScrollbar.concat.min.js"></script>' +
                  '<script type="text/javascript" src="/assets/js/plugins/datepicker.js"></script>' +
                  '<script type="text/javascript">' +
                  '      jQuery(document).ready(function() { ' +
                  '        	App.init(); ' +
                  '         App.initCounter(); ' +
                  '         App.initScrollBar(); ' +
                  '         Datepicker.initDatepicker(); ' +
                  '      }); ' +
                  '</script>'                     
                  
        else
                       
            ret = '<script type="text/javascript">' +
                  '    jQuery(document).ready(function() { ' +
                  '          App.init();    ' +
                  '    });  ' +
                  '</script>'
            
        end     
        
        ret
       
    end
    
    
    def self.get_css(controller_name, page_name)
        
        if controller_name == 'homes' && page_name == 'index'        
            
            ret = '<link rel="stylesheet" href="/assets/plugins/parallax-slider/css/parallax-slider.css">' +
                  '<link rel="stylesheet" href="/assets/plugins/owl-carousel/owl-carousel/owl.carousel.css">' 
                  
        elsif controller_name == 'mypages' && ( page_name == 'overall' || page_name == 'user_info' || page_name == 'payment' || page_name == 'payment_return' )
            
            ret = '<link rel="stylesheet" href="/assets/plugins/scrollbar/css/jquery.mCustomScrollbar.css">' +
                  '<link rel="stylesheet" href="/assets/plugins/sky-forms-pro/skyforms/css/sky-forms.css">' +
                  '<link rel="stylesheet" href="/assets/plugins/sky-forms-pro/skyforms/custom/custom-sky-forms.css">' +
                  '<!-- CSS Page Style -->' +
                  '<link rel="stylesheet" href="/assets/css/pages/profile.css">'
                  
        elsif controller_name == 'inicis_payments' && page_name == 'new'          
                  
            ret = '<link rel="stylesheet" href="/assets/plugins/scrollbar/css/jquery.mCustomScrollbar.css">' +
                  '<link rel="stylesheet" href="/assets/plugins/sky-forms-pro/skyforms/css/sky-forms.css">' +
                  '<link rel="stylesheet" href="/assets/plugins/sky-forms-pro/skyforms/custom/custom-sky-forms.css">' +
                  '<!-- CSS Page Style -->' +
                  '<link rel="stylesheet" href="/assets/css/pages/profile.css">'                  
                  
        elsif controller_name == 'payments' && page_name == 'index'

            ret = '<link rel="stylesheet" href="/assets/plugins/parallax-slider/css/parallax-slider.css">' +
                  '<link rel="stylesheet" href="/assets/plugins/flexslider/flexslider.css">' +
                  '<!-- CSS Page Style -->' +
                  '<link rel="stylesheet" href="/assets/css/pages/pricing/pricing_v1.css">' +
                  '<link rel="stylesheet" href="/assets/css/pages/pricing/pricing_v2.css">' +
                  '<link rel="stylesheet" href="/assets/css/pages/pricing/pricing_v3.css">' +
                  '<link rel="stylesheet" href="/assets/css/pages/pricing/pricing_v4.css">' +
                  '<link rel="stylesheet" href="/assets/css/pages/pricing/pricing_v5.css">'       

        end    
        
        ret
        
    end     
    
end    