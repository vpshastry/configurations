set print pretty
set history save
set history filename ~/.gdb_history
set history size 1000
define pdict
        set $curr = $arg0->members_list
        while $curr
                printf "%s = %p %s\n", $curr->key, $curr->value, $curr->value->data
                set $curr = $curr->next
        end
end

define pxlator
        printf "--- xlator %s type %s\n", $arg0->name, $arg0->type
        set $d = $arg0->options->members_list
        while $d
                printf "    option %s = %s\n", $d->key, $d->value->data
                set $d = $d->next
        end
        set $x = $arg0->children
        while $x
                printf "    subvolume %s\n", $x->xlator->name
                set $x = $x->next
        end
end

define ptrav
        pxlator $arg0->xlator
        if $arg0->xlator->children
                ptrav $arg0->xlator->children
        end
        if $arg0->next
                ptrav $arg0->next
        end
end

define pgraph
        pxlator $arg0
        if $arg0->children
                ptrav $arg0->children
        end
end

define playout_ent
        if $arg1 < $arg2
                set $ent = $arg0[$arg1]
                printf "  err=%d, start=0x%x, stop=0x%x, xlator=%s\n", \
                               $ent.err, $ent.start, $ent.stop, $ent.xlator->name
                playout_ent $arg0 $arg1+1 $arg2
        end
end

define playout
        printf "spread_cnt=%d\n", $arg0->spread_cnt
        printf "cnt=%d\n", $arg0->cnt
        printf "preset=%d\n", $arg0->preset
        printf "gen=%d\n", $arg0->gen
        printf "type=%d\n", $arg0->type
        printf "search_unhashed=%d\n", $arg0->search_unhashed
        playout_ent $arg0->list 0 $arg0->cnt
end
