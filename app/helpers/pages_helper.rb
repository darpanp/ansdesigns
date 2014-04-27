module PagesHelper
  def clearErrors
    flash[:error] = nil
  end
  #implement the flexing of title for register vs other pages here and use it in layout
  #See shovell for example on story index vs bin
  def case_condition 
    controller_name + '/' + controller.action_name
  end
=begin    
  def title_on_header
    title_header = case case_condition
    when 'users/new', 'users/create'
      "<h1>Register<span></span><em>in a single click</em></h1>
      <p>Registering with our website allows you to keep track of ongoing projects and many ways to interact with us.</p>
      <p>You will be taken to your personal homepage after registration completes.</p>
      <p><a href=\"" + pages_home_path + "\">Click here</a> to get back to company's homepage.</p>"
    when 'quotes/create', 'quotes/quote_first', 'quotes/quote_second', 'quotes/quote_third', 'quotes/quote_fourth' 
      "<h1>Get a Quote<span>in four</span><em>simple steps</em></h1>
      <p>If you have anything urgent, that is important to us too. We are not going anywhere so you have a freedom to save quote and return later.</p>
      <div class=\"wrapper\"><a href=\"#\" class=\"button\">Save For Now</a></div>"
    else
      "<h1>Accuracy<span>is the main feature</span><em>of our drawings</em></h1>
      <p>We believe that accuracy cannot be compromised at all. This is reflected through our previous work and testimonials.</p>
      <div class=\"wrapper\"><a href=\"#\" class=\"button\">View Our Works</a></div>"
    end
    title_header # + ' ' + controller_name + ' ' + controller.action_name
  end

  def left_navigation_section_on_header
    left_nav_items = case case_condition
    when 'quotes/create', 'quotes/quote_first'
        "<ul>
          <li>Step 1 - Provide Contact Info</li>
          <li><a href=\"#\">Step 2 - Select Work Type</a></li>
          <li><a href=\"#\">Step 3 - Price Quote</a></li>
          <li><a href=\"#\">Step 4 - Finalize Deal</a></li>
        </ul>"
    when 'quotes/quote_second'
        "<ul>
          <li><a href=\"#\">Step 1 - Provide Contact Info</a></li>
          <li>Step 2 - Select Work Type</li>
          <li><a href=\"#\">Step 3 - Price Quote</a></li>
          <li><a href=\"#\">Step 4 - Finalize Deal</a></li>
        </ul>"
    when 'quotes/quote_third'  
        "<ul>
          <li><a href=\"#\">Step 1 - Provide Contact Info</a></li>
          <li><a href=\"#\">Step 2 - Select Work Type</a></li>
          <li>Step 3 - Price Quote</li>
          <li><a href=\"#\">Step 4 - Finalize Deal</a></li>
        </ul>"
    when 'quotes/quote_fourth'
        "<ul>
          <li><a href=\"#\">Step 1 - Provide Contact Info</a></li>
          <li><a href=\"#\">Step 2 - Select Work Type</a></li>
          <li><a href=\"#\">Step 3 - Price Quote</a></li>
          <li>Step 4 - Finalize Deal</li>
        </ul>"
    else
      "<ul>
          <li><a href=\"#\">Architectural Drawings</a></li>
          <li><a href=\"#\">Permitting Drawings</a></li>
          <li><a href=\"#\">Construction Documents</a></li>
          <li><a href=\"#\">CADD as Built Drawings</a></li>
          <li><a href=\"#\">Measured Drawings</a></li>
          <li><a href=\"#\">Redline Drawings</a></li>
          <li><a href=\"#\">Fabrication Drawings</a></li>
        </ul>
        <div class=\"wrapper\"><a href=\"../pages/services\#services\" class=\"link1\"><em><b>Detailed Services</b></em></a></div>"
    end
    left_nav_items
  end
=end  
end
