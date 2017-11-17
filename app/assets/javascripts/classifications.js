$(document).ready(function(){
    var data = [
        {
            name: 'Dry ingredients',
            children: [
                { name: 'Flour' },
                { name: 'Yeasts',
                    children: [
                        { name: 'Level 3',
                            children: [
                                { name: 'Level 4' },
                                { name: 'Level 4',
                                    children: [
                                        { name: 'Level 5'}
                                    ]
                                },
                            ]
                        },
                    ]
                },
                { name: 'Additions' },
            ]
        },
        {
            name: 'Wet ingredients',
            children: [
                { name: 'Butter' },
                { name: 'Eggs' }
            ]
        }
    ];

    $("#levels-tree").tree({
        closedIcon: $('<i class="fa fa-plus"></i>'),
        openedIcon: $('<i class="fa fa-minus"></i>')
    });
});