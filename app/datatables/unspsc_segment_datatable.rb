class UnspscSegmentDatatable
  delegate :params, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: UnspscSegment.count,
        iTotalDisplayRecords: segments.total_entries,
        aaData: data
    }
  end

  private

  def data
    segments.map do |segment|
      [
          segment.code,
          segment.long_code,
          segment.description,
          link_to("View", "javascript:void(0)", class: "unspsc-drilldown", data: { href: filter_url(segment), type: "Families" } )
      ]
    end
  end

  def segments
    @segments ||= fetch_segments
  end

  def fetch_segments
    segments = UnspscSegment.order("#{sort_column} #{sort_direction}")
    segments = segments.page(page).per_page(per_page)
    if params[:sSearch].present?
      segments = segments.where("code like :search or long_code iLike :search or description iLike :search", search: "%#{params[:sSearch]}%")
    end
    segments
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

  def filter_url(segment)
    Rails.application.routes.url_helpers.unspsc_families_path(format: "json", unspsc_segment_id: segment.id)
  end
end