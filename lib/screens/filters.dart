import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  //Change from Stateful to -less and managed in Provider
  //Added Consumer- for Provider support
  const FiltersScreen({super.key /* ,required this.currentFilters */});

  //final Map<Filter, bool> currentFilters;

  /* @override
  ConsumerState<FiltersScreen> createState() {      --> State managed in Provider
    //Added Consumer- for Provider support
    return _FilterScreen();
  } */

  //class _FilterScreen extends ConsumerState<FiltersScreen> {    --> Change from stateful to stateless as state managed in Provider

  //Added Consumer- for Provider support
  /* var _glutenFreeFilterSet = false;        --> State managed in Provider
  var _lactoseFreeFilterSet = false;              
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false; */

  /* @override                                                  --> Change from stateful to stateless as state managed in Provider
  void initState() {
                           //we use initState in order to be able to initialize the FilterSets, as we cannot access the widget.currentFilters other than here or build().
    super.initState();
    final activeFilters = ref.read(filtersProvider);
    _glutenFreeFilterSet = activeFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = activeFilters[Filter.lactoseFree]!;
    _vegetarianFilterSet = activeFilters[Filter.vegetarian]!;
    _veganFilterSet = activeFilters[Filter.vegan]!;
  } */

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Added WidgetRef as we change from -stateful to -less
    final activeFilters = ref.watch(
      filtersProvider,
    ); //We initialize a local var with the Provider data

    return Scaffold(
      appBar: AppBar(title: const Text('Your Filters')),
      // drawer: MainDrawer(          --> Managed in Drawer widget
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'meals') {
      //       Navigator.of(
      //         context,
      //       ).push(MaterialPageRoute(builder: (ctx) => TabsScreen()));
      //     }
      //   },
      // ),
      body: /* PopScope(          --> PopScope deleted since state managed in Provider
        //Utility widget that allows to use OnPop to return upon a result when popping out.
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          ref.read(filtersProvider.notifier).setFilters({
            //We call directly the notifier so we can access the function .setFilters().
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
            Filter.vegan: _veganFilterSet,
          });
          if (didPop) return;
          Navigator.of(context).pop(
            /*{        //We return a map to send onPop which variable has been set.
              Filter.glutenFree: _glutenFreeFilterSet,
              Filter.lactoseFree: _lactoseFreeFilterSet,                                                ---> changed to .setFilters for Provider (l51)
              Filter.vegetarian: _vegetarianFilterSet,  
              Filter.vegan: _veganFilterSet, 
            }*/
          );
        },
        child: */ Column(
        children: [
          SwitchListTile(
            value: activeFilters[Filter.glutenFree]!,
            onChanged: (isChecked) {
              ref
                  .read(
                    filtersProvider.notifier,
                  ) //Changed .watch() to .read(), as .watch reexecutes build() function upon changes.
                  .setFilter(Filter.glutenFree, isChecked);
            },
            title: Text(
              'Glutten Free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              'Only include gluten-free meals',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            activeThumbColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.lactoseFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
            title: Text(
              'Lactose Free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              'Only include lactose-free meals',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            activeThumbColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.vegetarian]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
            title: Text(
              'Vegetarian',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              'Only include vegetarian meals',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            activeThumbColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.vegan]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
            title: Text(
              'Vegan',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              'Only include vegan meals',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            activeThumbColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
        ],
      ),
    );
  }
}
