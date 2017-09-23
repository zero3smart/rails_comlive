class UnspscCommodityDatatable
  delegate :params, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: UnspscCommodity.count,
        iTotalDisplayRecords: commodities.total_entries,
        aaData: data
    }
  end

  private

  def data
    commodities.map do |commodity|
      [
          commodity.code,
          commodity.long_code,
          commodity.description,
          link_to("Assign", "javascript:void(0)", class: "assign-unspsc", data: { id: commodity.id } )
      ]
    end
  end

  def commodities
    @commodities ||= fetch_commodities
  end

  def fetch_commodities
    commodities = unspsc_commodities.order("#{sort_column} #{sort_direction}")
    commodities = commodities.page(page).per_page(per_page)
    if params[:sSearch].present?
      commodities = commodities.where("code like :search or long_code iLike :search or description iLike :search", search: "%#{params[:sSearch]}%")
    end
    commodities
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 30
  end

  def sort_column
    columns = %w[code long_code description]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def unspsc_commodities
    UnspscClass.find(params[:unspsc_class_id]).unspsc_commodities
  end
end