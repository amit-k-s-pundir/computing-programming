Ext.onReady(function(){
//                alert("hello");
                var x = 0;
    //            x++;
     //           alert(x);
                var cm = new Ext.grid.ColumnModel(
                        {
                                defaults: 
                                {
                                        sortable: true
                                },
                                columns: [
                                {
                                        id: 'week1',
                                        header: 'Week 1',
                                        dataIndex: 'week1',
                                        width: '200',
                                        editor: new Ext.form.TextField(
                                                {
                                                        allowBlank: false
                                                })
                                }]
                        });

  //              x++;
   //             alert(x);

                var store = new Ext.data.Store({
                                autoDestroy: true,
                                url: '',
//                                reader: '',
 //                               sortInfo: '',
                        });
//                x++;
 //               alert(x);

                var grid = new Ext.grid.EditorGridPanel({
                                store: store,
                                cm: cm,
                                renderTo: 'panel1',
                                width: 600,
                                height: 400,
//                                autoExpandColumn: 'common',
                                title: 'General Timesheet',
                                frame: true,
                //                plugins: '',
                                clickToEdit: 1,
                                tbar: [{
                                        text: 'Edit Timesheet',
                                        handler: function(){
                                        }
                                }]
                        });
//                x++;
 //               alert(x);

                /**
                store.load(
                        {
                                callback: function()
                                {
                                        Ext.Msg.show(
                                                {
                                                        title: 'Timesheet load callback',
                                                        msg: 'Timesheet has been loaded.',
                                                });
                                }
                        });
**/
  //              x++;
   //             alert("sonu");

      //          Ext.Msg.show({
       //                         msg: 'extjs!',
        //                });
//
 //               x++;
    //            alert(x);
     //           alert("hello");
        });

