require_relative './ofsted-report-scraper.rb'

# Searches what you might make
searches = {
    all_schools: "1/any/any/any/any/any/any/any/any/any/0/0",
    primary_schools: "1/21/any/any/any/any/any/any/any/any/0/0",
    secondary_schools: "1/23/any/any/any/any/any/any/any/any/0/0"
}

# Pick things
specified_report_types = ["School inspection report","School short inspection report"]
search = searches [:primary_schools] # Pick your search type

  REPORT_TYPES = specified_report_types
  KEYWORD_SEARCHES = [/scien/i,/math/i,/investigation|experiment/i,/CPD|professional development/i]
  SEARCH_PAGE_URL = BASE_URL + "/inspection-reports/find-inspection-report/results/" + search + "?page="
  # e.g. "https://reports.ofsted.gov.uk/inspection-reports/find-inspection-report/results/1/any/any/any/any/any/any/any/any/any/0/0?page=",

# Download search result pages for specified search string above, write to CSV
write_CSV(scrape_search_pages(0,20),'./output/all_primary_schools_test.csv')

# Download a list of all results from 
write_CSV(scrape_school_pages('./output/all_primary_schools_test.csv'),'./output/all_primary_school_inspection_reports_test.csv')

# Download all the PDFs from a list of PDFs, optionally specify a year
download_report_pdfs('./output/all_primary_school_inspection_reports_test.csv','./output/all_primary_school_pdfs_test/','2015')

# Convert all the PDFs in a folder, generating .txt files
convert_pdfs('./output/all_primary_school_pdfs_test/')

# Scan the pdfs for key terms
write_CSV(scan_reports('./output/all_primary_school_pdfs_test/'),'./output/all_primary_school_science_mentions_test.csv')