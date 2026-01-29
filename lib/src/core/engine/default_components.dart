import 'component_registry.dart';
import '../../components/list/list_view.dart';
import '../../components/grid/datagrid.dart';
import '../../components/field/text_field.dart';

/// Registers the default components available in the framework.
void registerDefaultComponents() {
  ComponentRegistry().register('List', ListViewComponent.builder);
  ComponentRegistry().register('Datagrid', Datagrid.builder);
  ComponentRegistry().register('TextField', TextFieldComponent.builder);
}
