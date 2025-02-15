import 'package:brasil_fields/brasil_fields.dart';
import 'package:dealteachingfront/modules/backoffice/home/controller/home_controller.dart';
import 'package:dealteachingfront/services/form_field_custom.dart';
import 'package:dealteachingfront/services/global_state_service.dart';
import 'package:dealteachingfront/widgets/form_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? errorMessageCategory;
  String? errorMessageCondominiuns;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // categoryController = context.read<CategoryController>();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   categoryController.loadCategories();
    //   controller.loadcondominiums();
    // });
  }

  @override
  Widget build(BuildContext context) {
    var spacer = MediaQuery.sizeOf(context).width > 1060;
    return Consumer<HomePageController>(
      builder: (context, controller, child) => Scaffold(
          body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(30),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                blurRadius: 2,
                offset: Offset(0, 2),
                color: Colors.black26,
              )
            ],
            color: Colors.white,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Cadastro do cliente',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(54, 63, 77, 1),
                        fontSize: 17,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.formClear();
                      },
                      child: const Text(
                        'Limpar campos',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                FormLine(
                  spacer: spacer,
                  children: [
                    TextFormFieldCustom(
                      controller: controller.nome,
                      label: 'Nome *',
                      textType: TextInputType.name,
                      // validator: controller.validarNome(value),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                      ],
                      onChanged: (value) {
                        controller.validateNome(value);
                        formKey.currentState?.validate();
                        setState(() {});
                      },
                      maxLength: 50,
                      errorText: controller.nameInvalid,
                    ),
                    const Gap(20),
                    TextFormFieldCustom(
                      errorText: controller.dateInvalid,
                      controller: controller.dataNascimento,
                      label: 'Data de nascimento*',
                      textType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        DataInputFormatter()
                      ],
                      // validator: Validator.empty(),
                      onChanged: (value) {
                        controller.validateData(value);
                        formKey.currentState?.validate();
                        setState(() {});
                      },
                    ),
                    const Gap(20),
                    TextFormFieldCustom(
                      errorText: controller.agencyInvalid,
                      maxLength: 5,
                      controller: controller.agencia,
                      textType: TextInputType.number,
                      label: 'Agência',
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      // validator: Validator.empty(),
                      onChanged: (value) {
                        controller.validateAgencia(value);
                        formKey.currentState?.validate();
                        setState(() {});
                      },
                    ),
                  ],
                ),
                const Gap(20),
                FormLine(
                  spacer: spacer,
                  children: [
                    TextFormFieldCustom(
                      errorText: controller.documentInvalid,
                      controller: controller.documento,
                      label: 'Documento *',
                      textType: TextInputType.number,
                      // validator: Validator.min(
                      //     6, 'Este campo tem que ter no mínimo 6 caracteres'),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CpfOuCnpjFormatter()
                      ],
                      onChanged: (value) {
                        controller.validateDocument(value);
                        formKey.currentState?.validate();
                        setState(() {});
                      },
                    ),
                    const Gap(20),
                    TextFormFieldCustom(
                      errorText: controller.emailInvalid,
                      controller: controller.email,
                      textType: TextInputType.text,
                      label: 'E-mail',
                      onChanged: (value) {
                        controller.validadorEmail(value);
                        formKey.currentState?.validate();
                        setState(() {});
                      },
                    ),
                    const Gap(20),
                    Flexible(
                      child: SizedBox(
                        width: 300,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Tipo de conta',
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              DropdownButtonFormField<String>(
                                style: const TextStyle(color: Colors.black),
                                dropdownColor: Colors.white,
                                value: controller
                                    .selectedOption, // Deixe como null para não ter valor inicial
                                decoration: InputDecoration(
                                  filled: false,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.green),
                                  ),
                                ),
                                items: const [
                                  DropdownMenuItem<String>(
                                    value: 'CURRENT',
                                    child: Text('Conta Corrente'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'PAYMENT',
                                    child: Text('Conta Pagamento'),
                                  ),
                                ],
                                onChanged: (String? newValue) {
                                  controller.selectedOption = newValue;
                                  controller.registerValid();
                                  setState(() {});
                                },
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                FormLine(
                  spacer: spacer,
                  children: const [],
                ),
                const Gap(20),
                FormLine(
                  spacer: spacer,
                  children: const [],
                ),
                const Gap(30),
                const Gap(100),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      fixedSize: const Size(150, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: !controller.registerValid()
                        ? null
                        : () async {
                            controller.register();
                            setState(() {});
                          },
                    child: controller.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Row(
                            children: [
                              Icon(Icons.done, color: Colors.white),
                              Gap(5),
                              Text('Cadastrar'),
                            ],
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
