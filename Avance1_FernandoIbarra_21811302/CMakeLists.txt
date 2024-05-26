cmake_minimum_required(VERSION 3.8)
project(Expr)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

find_package(FLEX)
find_package(BISON)

FLEX_TARGET(ExprLexer ExprLexerImpl.l
            ${CMAKE_CURRENT_BINARY_DIR}/ExprLexerImpl.cpp
            DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/ExprLexerImpl.h
            )

BISON_TARGET(ExprParser ExprParserImpl.y
            ${CMAKE_CURRENT_BINARY_DIR}/ExprParserImpl.cpp
            DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/ExprParserImpl.hpp
            )

include_directories(${CMAKE_CURRENT_BINARY_DIR})
include_directories(${CMAKE_SOURCE_DIR})

add_executable(${PROJECT_NAME}
    ${FLEX_ExprLexer_OUTPUTS}
    ${BISON_ExprParser_OUTPUTS}
    ExprLexer.hpp
    ExprLexer.cpp
    ExprParser.hpp
    ExprParser.cpp
    main.cpp
)

# Agregar un objetivo personalizado para ejecutar los archivos de prueba
add_custom_target(run_tests ALL
    COMMAND ${CMAKE_COMMAND} -E echo ""
    COMMAND ${CMAKE_COMMAND} -E echo "=============================="
    COMMAND ${CMAKE_COMMAND} -E echo "      Running Test Cases"
    COMMAND ${CMAKE_COMMAND} -E echo "=============================="
    COMMAND ${CMAKE_COMMAND} -E echo ""

    COMMAND ${CMAKE_COMMAND} -E echo "Running AddIntInt.lpp"
    COMMAND ${PROJECT_BINARY_DIR}/${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/tests/AddIntInt.lpp 2>/dev/null && ${CMAKE_COMMAND} -E echo "✅ AddIntInt.lpp passed" || ${CMAKE_COMMAND} -E echo "❌ AddIntInt.lpp failed"
    COMMAND ${CMAKE_COMMAND} -E echo "---------------------------------"

    COMMAND ${CMAKE_COMMAND} -E echo "Running BoolTest.lpp"
    COMMAND ${PROJECT_BINARY_DIR}/${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/tests/BoolTest.lpp 2>/dev/null && ${CMAKE_COMMAND} -E echo "✅ BoolTest.lpp passed" || ${CMAKE_COMMAND} -E echo "❌ BoolTest.lpp failed"
    COMMAND ${CMAKE_COMMAND} -E echo "---------------------------------"

    COMMAND ${CMAKE_COMMAND} -E echo "Running CharTest.lpp"
    COMMAND ${PROJECT_BINARY_DIR}/${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/tests/CharTest.lpp 2>/dev/null && ${CMAKE_COMMAND} -E echo "✅ CharTest.lpp passed" || ${CMAKE_COMMAND} -E echo "❌ CharTest.lpp failed"
    COMMAND ${CMAKE_COMMAND} -E echo "---------------------------------"

    COMMAND ${CMAKE_COMMAND} -E echo "Running fibonacci.lpp"
    COMMAND ${PROJECT_BINARY_DIR}/${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/tests/fibonacci.lpp 2>/dev/null && ${CMAKE_COMMAND} -E echo "✅ fibonacci.lpp passed" || ${CMAKE_COMMAND} -E echo "❌ fibonacci.lpp failed"
    COMMAND ${CMAKE_COMMAND} -E echo "---------------------------------"

    COMMAND ${CMAKE_COMMAND} -E echo "Running gcd.lpp"
    COMMAND ${PROJECT_BINARY_DIR}/${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/tests/gcd.lpp 2>/dev/null && ${CMAKE_COMMAND} -E echo "✅ gcd.lpp passed" || ${CMAKE_COMMAND} -E echo "❌ gcd.lpp failed"
    COMMAND ${CMAKE_COMMAND} -E echo "---------------------------------"

    COMMAND ${CMAKE_COMMAND} -E echo "Running HolaMundo.lpp"
    COMMAND ${PROJECT_BINARY_DIR}/${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/tests/HolaMundo.lpp 2>/dev/null && ${CMAKE_COMMAND} -E echo "✅ HolaMundo.lpp passed" || ${CMAKE_COMMAND} -E echo "❌ HolaMundo.lpp failed"
    COMMAND ${CMAKE_COMMAND} -E echo "---------------------------------"

    COMMAND ${CMAKE_COMMAND} -E echo "Running SelectionSort.lpp"
    COMMAND ${PROJECT_BINARY_DIR}/${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/tests/SelectionSort.lpp 2>/dev/null && ${CMAKE_COMMAND} -E echo "✅ SelectionSort.lpp passed" || ${CMAKE_COMMAND} -E echo "❌ SelectionSort.lpp failed"
    COMMAND ${CMAKE_COMMAND} -E echo "---------------------------------"

    COMMAND ${CMAKE_COMMAND} -E echo "Running TestArray1DInt.lpp"
    COMMAND ${PROJECT_BINARY_DIR}/${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/tests/TestArray1DInt.lpp 2>/dev/null && ${CMAKE_COMMAND} -E echo "✅ TestArray1DInt.lpp passed" || ${CMAKE_COMMAND} -E echo "❌ TestArray1DInt.lpp failed"
    COMMAND ${CMAKE_COMMAND} -E echo "---------------------------------"

    COMMAND ${CMAKE_COMMAND} -E echo "Running TestMientras.lpp"
    COMMAND ${PROJECT_BINARY_DIR}/${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/tests/TestMientras.lpp 2>/dev/null && ${CMAKE_COMMAND} -E echo "✅ TestMientras.lpp passed" || ${CMAKE_COMMAND} -E echo "❌ TestMientras.lpp failed"
    COMMAND ${CMAKE_COMMAND} -E echo "---------------------------------"

    COMMAND ${CMAKE_COMMAND} -E echo "Running TestPara.lpp"
    COMMAND ${PROJECT_BINARY_DIR}/${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/tests/TestPara.lpp 2>/dev/null && ${CMAKE_COMMAND} -E echo "✅ TestPara.lpp passed" || ${CMAKE_COMMAND} -E echo "❌ TestPara.lpp failed"
    COMMAND ${CMAKE_COMMAND} -E echo "---------------------------------"

    COMMAND ${CMAKE_COMMAND} -E echo "Running TestRepita.lpp"
    COMMAND ${PROJECT_BINARY_DIR}/${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/tests/TestRepita.lpp 2>/dev/null && ${CMAKE_COMMAND} -E echo "✅ TestRepita.lpp passed" || ${CMAKE_COMMAND} -E echo "❌ TestRepita.lpp failed"
    COMMAND ${CMAKE_COMMAND} -E echo "---------------------------------"

    COMMAND ${CMAKE_COMMAND} -E echo "Running TestSi.lpp"
    COMMAND ${PROJECT_BINARY_DIR}/${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/tests/TestSi.lpp 2>/dev/null && ${CMAKE_COMMAND} -E echo "✅ TestSi.lpp passed" || ${CMAKE_COMMAND} -E echo "❌ TestSi.lpp failed"
    COMMAND ${CMAKE_COMMAND} -E echo "---------------------------------"

    COMMAND ${CMAKE_COMMAND} -E echo "Running TestSubprg1.lpp"
    COMMAND ${PROJECT_BINARY_DIR}/${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/tests/TestSubprg1.lpp 2>/dev/null && ${CMAKE_COMMAND} -E echo "✅ TestSubprg1.lpp passed" || ${CMAKE_COMMAND} -E echo "❌ TestSubprg1.lpp failed"
    COMMAND ${CMAKE_COMMAND} -E echo "---------------------------------"

    COMMAND ${CMAKE_COMMAND} -E echo "Running TestSubprg2.lpp"
    COMMAND ${PROJECT_BINARY_DIR}/${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/tests/TestSubprg2.lpp 2>/dev/null && ${CMAKE_COMMAND} -E echo "✅ TestSubprg2.lpp passed" || ${CMAKE_COMMAND} -E echo "❌ TestSubprg2.lpp failed"
    COMMAND ${CMAKE_COMMAND} -E echo "---------------------------------"

    COMMAND ${CMAKE_COMMAND} -E echo "Running TestSubprg5.lpp"
    COMMAND ${PROJECT_BINARY_DIR}/${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/tests/TestSubprg5.lpp 2>/dev/null && ${CMAKE_COMMAND} -E echo "✅ TestSubprg5.lpp passed" || ${CMAKE_COMMAND} -E echo "❌ TestSubprg5.lpp failed"
    COMMAND ${CMAKE_COMMAND} -E echo "---------------------------------"

    COMMAND ${CMAKE_COMMAND} -E echo "Running TestSubprg8.lpp"
    COMMAND ${PROJECT_BINARY_DIR}/${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/tests/TestSubprg8.lpp 2>/dev/null && ${CMAKE_COMMAND} -E echo "✅ TestSubprg8.lpp passed" || ${CMAKE_COMMAND} -E echo "❌ TestSubprg8.lpp failed"
    COMMAND ${CMAKE_COMMAND} -E echo "---------------------------------"

    COMMAND ${CMAKE_COMMAND} -E echo "Running TestSubprg9.lpp"
    COMMAND ${PROJECT_BINARY_DIR}/${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/tests/TestSubprg9.lpp 2>/dev/null && ${CMAKE_COMMAND} -E echo "✅ TestSubprg9.lpp passed" || ${CMAKE_COMMAND} -E echo "❌ TestSubprg9.lpp failed"
    COMMAND ${CMAKE_COMMAND} -E echo "---------------------------------"

    COMMAND ${CMAKE_COMMAND} -E echo "Running TestSubprg17.lpp"
    COMMAND ${PROJECT_BINARY_DIR}/${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/tests/TestSubprg17.lpp 2>/dev/null && ${CMAKE_COMMAND} -E echo "✅ TestSubprg17.lpp passed" || ${CMAKE_COMMAND} -E echo "❌ TestSubprg17.lpp failed"
    COMMAND ${CMAKE_COMMAND} -E echo "---------------------------------"

    COMMAND ${CMAKE_COMMAND} -E echo "Running TestSubprg18.lpp"
    COMMAND ${PROJECT_BINARY_DIR}/${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/tests/TestSubprg18.lpp 2>/dev/null && ${CMAKE_COMMAND} -E echo "✅ TestSubprg18.lpp passed" || ${CMAKE_COMMAND} -E echo "❌ TestSubprg18.lpp failed"
    COMMAND ${CMAKE_COMMAND} -E echo "---------------------------------"

    COMMAND ${CMAKE_COMMAND} -E echo "=============================="
    COMMAND ${CMAKE_COMMAND} -E echo "        Test Cases Done"
    COMMAND ${CMAKE_COMMAND} -E echo "=============================="
    COMMAND ${CMAKE_COMMAND} -E echo ""

    COMMAND ${CMAKE_COMMAND} -E echo "Test Results:"
    COMMAND ${CMAKE_COMMAND} -E echo "---------------------------------"
    COMMAND ${CMAKE_COMMAND} -E echo "| Test File           | Result   |"
    COMMAND ${CMAKE_COMMAND} -E echo "|---------------------|----------|"
    COMMAND ${CMAKE_COMMAND} -E echo "| AddIntInt.lpp       | $<TARGET_PROPERTY:AddIntInt.lpp,RESULT> |"
    COMMAND ${CMAKE_COMMAND} -E echo "| BoolTest.lpp        | $<TARGET_PROPERTY:BoolTest.lpp,RESULT>  |"
    COMMAND ${CMAKE_COMMAND} -E echo "| CharTest.lpp        | $<TARGET_PROPERTY:CharTest.lpp,RESULT>  |"
    COMMAND ${CMAKE_COMMAND} -E echo "| fibonacci.lpp       | $<TARGET_PROPERTY:fibonacci.lpp,RESULT> |"
    COMMAND ${CMAKE_COMMAND} -E echo "| gcd.lpp             | $<TARGET_PROPERTY:gcd.lpp,RESULT>       |"
    COMMAND ${CMAKE_COMMAND} -E echo "| HolaMundo.lpp       | $<TARGET_PROPERTY:HolaMundo.lpp,RESULT> |"
    COMMAND ${CMAKE_COMMAND} -E echo "| SelectionSort.lpp   | $<TARGET_PROPERTY:SelectionSort.lpp,RESULT> |"
    COMMAND ${CMAKE_COMMAND} -E echo "| TestArray1DInt.lpp  | $<TARGET_PROPERTY:TestArray1DInt.lpp,RESULT> |"
    COMMAND ${CMAKE_COMMAND} -E echo "| TestMientras.lpp    | $<TARGET_PROPERTY:TestMientras.lpp,RESULT> |"
    COMMAND ${CMAKE_COMMAND} -E echo "| TestPara.lpp        | $<TARGET_PROPERTY:TestPara.lpp,RESULT> |"
    COMMAND ${CMAKE_COMMAND} -E echo "| TestRepita.lpp      | $<TARGET_PROPERTY:TestRepita.lpp,RESULT> |"
    COMMAND ${CMAKE_COMMAND} -E echo "| TestSi.lpp          | $<TARGET_PROPERTY:TestSi.lpp,RESULT> |"
    COMMAND ${CMAKE_COMMAND} -E echo "| TestSubprg1.lpp     | $<TARGET_PROPERTY:TestSubprg1.lpp,RESULT> |"
    COMMAND ${CMAKE_COMMAND} -E echo "| TestSubprg2.lpp     | $<TARGET_PROPERTY:TestSubprg2.lpp,RESULT> |"
    COMMAND ${CMAKE_COMMAND} -E echo "| TestSubprg5.lpp     | $<TARGET_PROPERTY:TestSubprg5.lpp,RESULT> |"
    COMMAND ${CMAKE_COMMAND} -E echo "| TestSubprg8.lpp     | $<TARGET_PROPERTY:TestSubprg8.lpp,RESULT> |"
    COMMAND ${CMAKE_COMMAND} -E echo "| TestSubprg9.lpp     | $<TARGET_PROPERTY:TestSubprg9.lpp,RESULT> |"
    COMMAND ${CMAKE_COMMAND} -E echo "| TestSubprg17.lpp    | $<TARGET_PROPERTY:TestSubprg17.lpp,RESULT> |"
    COMMAND ${CMAKE_COMMAND} -E echo "| TestSubprg18.lpp    | $<TARGET_PROPERTY:TestSubprg18.lpp,RESULT> |"
    COMMAND ${CMAKE_COMMAND} -E echo "---------------------------------"
    COMMAND ${CMAKE_COMMAND} -E echo ""
    DEPENDS ${PROJECT_NAME}
)


add_dependencies(run_tests ${PROJECT_NAME})
