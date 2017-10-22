export default class CustomDataTables {
  constructor() {
    this.createTables = this.createTables.bind(this);
    this.createTable  = this.createTable.bind(this);
    this.domString    = this.domString.bind(this);
    this.tables       = $('.custom-datatable');
    this.createTables();
  }

  createTables() {
    return Array.from(this.tables).map((table) => this.createTable($(table)));
  }

  createTable($table) {
    return $table.dataTable({
      serverSide: true,
      processing: true,
      fixedColumns: true,
      search: {
        regex: false
      },
      order: [ [0, 'asc'] ],
      lengthMenu: [
        [10, 25, 50, 100],
        [10, 25, 50, 100]
      ],
      pageLength: this.pageLength($table),
      dom: this.domString($table),
      buttons: [],
      rowCallback: (row, data) => {
        if (this.tables.data('showOnClick')) {
          $(row).css('cursor', 'pointer');
          return $(row).click(function() {
            const tagClicked = event.target.tagName;
            const allowShow = event.target.className.includes('allow-show')
            if (!allowShow && ((tagClicked === 'A') || (tagClicked === 'SPAN'))) {
              return;
            }
            const parentLink = $(row).closest('table').data('show');
            let id = data[0];
            if (typeof id === 'string') {
              id = id.replace ( /[^\d.]/g, '' );
            }
            return document.location.href = `${parentLink}/${id}`;
          });
        }
      }
    });
  }

  domString($table) {
    return "<'row' <'col-md-12'>><'row'<'col-md-6 col-sm-6 col-l row-height'l><'col-md-6 col-sm-12 col-f text-right row-height'f>r><'table-scrollable't><'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>";
  }

  pageLength($table) {
    return $table.data('page') || 25;
  }
}
