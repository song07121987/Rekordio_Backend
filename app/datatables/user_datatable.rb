class UserDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: users.count,
      iTotalDisplayRecords: users.total_entries,
      aaData: data.compact
    }
  end

  private

  def data
    users.map do |user|
      edit_link    = link_to(user.id, "/dashboard/users/#{user.id}/edit")
      status_id    = user.id
      status_class = "User"
      switch_label = "<div class='btn-group btn-toggle' data-update-url='/dashboard/update_status'>
          <button class='btn btn-xs #{user[:status]==1 ? 'btn-success active' : 'btn-default'}' style='padding:1px 5px' data-id='#{status_id}' data-status='1' data-type='#{status_class}'>Yes</button>
          <button class='btn btn-xs #{user[:status]==0 ? 'btn-warning active' : 'btn-default'}' style='padding:1px 5px' data-id='#{status_id}' data-status='0' data-type='#{status_class}'>No</button>
        </div>".html_safe
      [
        edit_link,
        user.salutation,
        user.first_name,
        user.last_name,
        user.preferred_first_name,
        user.phone,
        user.specialty,
        user.fax,
        user.registered_at.present? ? user.registered_at.strftime("%b %-d %Y") : nil,
        user.pin,
        user.last_login,
        switch_label,
        "row_#{user.id}"
      ]
    end
  end

  def users
    @users ||= fetch_users
  end

  def fetch_users
    status = params[:show_option].strip == "Include disabled"  ?  false : true

    if params[:sSearch].present?
      users = status ? User.where("#{search_where_case}", search_param: "%#{params[:sSearch]}%")
                           .order(order_case).paginate(page: page, per_page: per_page)
                     : User.where("#{search_where_case} AND status = 1", search_param: "%#{params[:sSearch]}%")
                           .order(order_case).paginate(page: page, per_page: per_page)
    else
      users = status ? User.where(member_type: User::MEMBER_TYPE[:app]).order(order_case).paginate(page: page, per_page: per_page)
                     : User.where(member_type: User::MEMBER_TYPE[:app], status: 1).order(order_case).paginate(page: page, per_page: per_page)
    end
    users
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 15
  end

  def sort_column
    columns = %w[id salutation first_name last_name preferred_first_name phone specialty fax registered_at pin pin_created_at status]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def search_where_case
    "(first_name LIKE :search_param OR "\
    "last_name LIKE :search_param OR "\
    "phone LIKE :search_param OR "\
    "specialty LIKE :search_param OR "\
    "fax LIKE :search_param OR "\
    "pin LIKE :search_param) AND "\
    "member_type = #{User::MEMBER_TYPE[:app]}"
  end

  def order_case
    "#{sort_column} #{sort_direction}"
  end
end