
class ToolsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    tools = user.tools
    render json: tools
  end

  def create
    puts params
    if Tool.create(user_id: params[:user_id], title: params[:title], description: params[:description])
      render json: {message: "Tool created successfully"}
    else
      render json: {message: "Attempt unsuccesful"}
    end
  end

  def search
    current_location = find_current_location(params)
    possible_tools = find_tools_matching_keyword(params[:keyword])
    reject_own_tools(possible_tools, params[:user])
    possible_tools_hash = find_tool_distances(possible_tools, current_location)
    close_tools = possible_tools_hash.select{ |tool, distance| distance < 20}
    json_tools = convert_to_json(close_tools)
    render json: json_tools
  end


  def reject_own_tools(tool_array, user_id)
    tool_array.reject!{ |tool| tool.user.id == user_id }
  end

  def find_tool_distances(tools_array, current_location)
    Hash[ tools_array.collect{ |tool| [tool, find_distance(tool, current_location)] }]
  end

  def find_distance(tool, current_location)
    get_geo(tool.user).distance_to(current_location).round(1)
  end

  def convert_to_json(tools_hash)
    tools_hash.map do |tool, distance|
      { tool: tool, owner: tool.user, distance: distance}
    end
  end

  def find_tools_matching_keyword(search_term)
    search_term.downcase!
    tools = Tool.all
    tools_title_match, tools_no_title_match = [], []
    tools.each do |tool|
      tool.title.downcase.include?(search_term) ? tools_title_match << tool : tools_no_title_match << tool
    end
    tools_with_desc = tools_no_title_match.select{ |tool| tool.description }
    tools_desc_match = tools_with_desc.select{ |tool| tool.description.downcase.include?(search_term) }
    search_results = tools_title_match + tools_desc_match
    search_results
  end

  def find_current_location(params)
    Geokit::Geocoders::MultiGeocoder.geocode "#{params[:latitude]}, #{params[:longitude]}"
  end

  def full_address(user)
    if user.street_address_2 != nil
      "#{user.street_address_1}, #{user.street_address_2}, #{user.city}, #{user.state}"
    else
      "#{user.street_address_1}, #{user.city}, #{user.state}"
    end
  end

  def get_geo(user)
    Geokit::Geocoders::MultiGeocoder.geocode full_address(user)
  end
end
