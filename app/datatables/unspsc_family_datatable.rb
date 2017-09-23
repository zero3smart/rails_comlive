class UnspscFamilyDatatable
  delegate :params, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: UnspscFamily.count,
        iTotalDisplayRecords: families.total_entries,
        aaData: data
    }
  end

  private

  def data
    families.map do |family|
      [
          family.code,
          family.long_code,
          family.description,
          link_to("View", "javascript:void(0)", class: "unspsc-drilldown", data: { href: filter_url(family), type: "Classes" } )
      ]
    end
  end

  def families
    @families ||= fetch_families
  end

  def fetch_families
    families = unspsc_families.order("#{sort_column} #{sort_direction}")
    families = families.page(page).per_page(per_page)
    if params[:sSearch].present?
      families = families.where("code like :search or long_code iLike :search or description iLike :search", search: "%#{params[:sSearch]}%")
    end
    families
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

  def unspsc_families
    UnspscSegment.find(params[:unspsc_segment_id]).unspsc_families
  end

  def filter_url(family)
    Rails.application.routes.url_helpers.unspsc_classes_path(format: "json", unspsc_family_id: family.id)
  end
end